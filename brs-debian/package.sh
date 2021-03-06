#!/usr/bin/env bash

archive_name="burstcoin-2.3.0.zip"
wget https://github.com/burst-apps-team/burstcoin/releases/download/v2.3.0/burstcoin-2.3.0.zip

mkdir -p build/etc/burstcoin-wallet/
mkdir -p build/etc/systemd/system/
mkdir -p build/DEBIAN

# Unzip archive
unzip ${archive_name} -d build/etc/burstcoin-wallet/

# Install as service
cp .debian/burstcoin-wallet.service build/etc/systemd/system/
cp .debian/control build/DEBIAN/control
cp .debian/prerm.sh build/DEBIAN/prerm

# Make scripts executable
chmod +x build/etc/burstcoin-wallet/burst.sh
chmod +x build/DEBIAN/prerm

# Build .deb package
dpkg-deb --build build
mv build.deb burstcoin-wallet.deb

# Cleanup build directory
rm -r build/
