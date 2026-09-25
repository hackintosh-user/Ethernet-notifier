# Ethernet-notifier
* A Ethernet notifier for Hackintosh Systems to let you know when the ethernet cable has went online!

<img width="1920" height="1080" alt="Screenshot 2026-09-25 at 2 16 20 PM" src="https://github.com/user-attachments/assets/bc513e26-8bd6-4e05-9f11-3cf3a608c874" />
* MacOS Sequoia with Ethernet-Notifier



## Features

* Seamless into macOS notifications
* Very low resource need (needs only about 11MB of ram)
* A menubar plugin that shows up as: **< .. >**


## Requirements


* macOS Sequoia and later
* Xcode command line tools (mainly for compiling manually, Head to [releases](https://github.com/hackintosh-user/Ethernet-notifier/releases) if you want the pre-built binary)
* A working Hackintosh
* A working ethernet on said hackintosh


## usage

* You can get the pre-built **.app binary** from [RELEASES](https://github.com/hackintosh-user/Ethernet-notifier/releases)



To manually Build this project,


Clone the repository:


```zsh
git clone https://github.com/hackintosh-user/Ethernet-notifier.git
```

* Then, Cd into your folder where the clone is located

```zsh
cd /path/to/Ethernet-notifier-MASTER/
```

Then make build.sh a exec binary via **chmod**:

```zsh
chmod +x build.sh
```


Then run build.sh to compile the Swift code (MUST HAVE **Xcode Command line tools!**):

```zsh
./build.sh
```

* After you should have the built Binary .app for **EthernetNotifier**
* There is a icons.png you can copy into the app's icon (not a dep but for looks).


## Credits

* Hackintosh-User

