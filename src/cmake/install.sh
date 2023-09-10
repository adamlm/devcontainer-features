#!/bin/sh

set -e

echo "[CMake Feature] Activating feature 'cmake'"
echo "[CMake Feature] The provided CMake version is: ${VERSION}"

if ! command -v wget &> /dev/null
then
    echo "[CMake Feature] 'wget' not found. Installing through 'apt'"
    apt update
    DEBIAN_FRONTEND=noninteractive apt install --yes --quiet wget
    rm -rf /var/lib/apt/lists/*
fi

echo "[CMake Feature] Downloading CMake binary"

cd /tmp
wget --quiet https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-linux-x86_64.sh
wget --quiet https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-linux-x86_64.tar.gz

echo "[CMake Feature] Installing CMake"

chmod u+x cmake-${VERSION}-linux-x86_64.sh
./cmake-${VERSION}-linux-x86_64.sh --skip-license --include-subdir --prefix=/opt

rm cmake-${VERSION}-linux-x86_64.sh
rm cmake-${VERSION}-linux-x86_64.tar.gz

echo 'export PATH=/opt/cmake-'${VERSION}'-linux-x86_64/bin:$PATH' >> /etc/profile.d/cmake_path.sh

cd -

echo "[CMake Feature] Done"
