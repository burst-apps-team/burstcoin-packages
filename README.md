# Burstcoin Packager

This repository contains a script to take a [released copy of the BRS](https://github.com/poc-consortium/burstcoin/releases) and build it into a Debian package, suitable for use on Debian, Ubuntu, Linux Mint etc.

The Debian packages are built by a Travis CI server.

## Installation / Setup

**Before starting, please make sure Java 8 is installed on your system. It is required by the BRS.** If you do not have java installed, run `sudo apt-get update && sudo apt-get install openjdk-8-jre`

Then, you need to install the Burstcoin wallet.

* Grab the latest release from [the releases page](releases/latest)

* Open a terminal and type `sudo dpkg -i /path/to/burstcoin-wallet.deb`, or install the package through a GUI.

Then, you can modify the configuration files to setup the wallet - they are stored in `/etc/burstcoin-wallet/conf/`

To start the wallet, you can then run `sudo systemctl start burstcoin-wallet`.

In order to make the wallet run at startup, run `sudo systemctl enable burstcoin-wallet`.

# Uninstall

* Open a terminal and run `sudo dpkg -P burstcoin-wallet`. This will automatically attempt to stop the wallet and uninstall all of its files (and will remove your `burst_db` if you are using H2!).

# Build your own!

In order to build your own file, clone the repository and grab the latest [BRS release](https://github.com/poc-consortium/burstcoin/releases).

Then copy it into the repo and modify `package.sh` - change the `archive_name` on line 3 to the name of the zip file you downloaded.

Then run `./packager.sh`. This will produce a file called `burstcoin-wallet.deb`
