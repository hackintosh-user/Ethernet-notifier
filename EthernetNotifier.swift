import SwiftUI
import Network
import UserNotifications

// MARK: - Network Monitor
class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "EthernetMonitorQueue")
    
    @Published var isEthernetConnected: Bool = false
    private var isInitialCheck = true

    init() {
        // Specifically monitor for wired Ethernet connections
        monitor = NWPathMonitor(requiredInterfaceType: .wiredEthernet)
        requestNotificationPermission()
        startMonitoring()
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let isConnected = (path.status == .satisfied)

                // Trigger a notification if the state changes to connected, 
                // or if it's already connected when the app first launches.
                if isConnected && (!self.isEthernetConnected || self.isInitialCheck) {
                    self.sendNotification()
                }

                self.isEthernetConnected = isConnected
                self.isInitialCheck = false
            }
        }
        monitor.start(queue: queue)
    }

    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Ethernet Connected"
        content.body = "Your Ethernet connection is online and ready for usage."
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - Main App Entry Point
@main
struct EthernetNotifierApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        // MenuBarExtra restricts the app's UI strictly to the macOS menu bar
        MenuBarExtra {
            VStack {
                Text(networkMonitor.isEthernetConnected ? "Ethernet: Online" : "Ethernet: Offline")
                Divider()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
        } label: {
            // The custom text icon for the menu bar
            Text("< . . >")
        }
    }
}