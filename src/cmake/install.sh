#!/bin/sh

set -e

echo "[CMake Feature] Activating feature 'cmake'"
echo "[CMake Feature] The provided CMake version is: ${VERSION}"

if ! command -v wget &> /dev/null
then
    echo "[CMake Feature] 'wget' not found. Installing through 'apt'"
    apt update
    DEBIAN_FRONTEND=noninteractive apt install --yes --quiet wget
fi

if ! command -v arch &> /dev/null
then
    echo "[CMake Feature] 'arch' not found. Installing through 'apt'"
    apt update
    DEBIAN_FRONTEND=noninteractive apt install --yes --quiet coreutils
fi

if command -v cmake &> /dev/null
then
    echo "[CMake Feature] Existing 'cmake' installation found. Uninstalling."
    DEBIAN_FRONTEND=noninteractive apt remove --yes --quiet cmake
fi

rm -rf /var/lib/apt/lists/*

echo "[CMake Feature] Downloading CMake binary"

ARCH=$(arch)

cd /tmp
wget --quiet https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-linux-${ARCH}.sh
wget --quiet https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-linux-${ARCH}.tar.gz

echo "[CMake Feature] Installing CMake"

chmod u+x cmake-${VERSION}-linux-${ARCH}.sh
./cmake-${VERSION}-linux-${ARCH}.sh --skip-license --include-subdir --prefix=/opt

rm cmake-${VERSION}-linux-${ARCH}.sh
rm cmake-${VERSION}-linux-${ARCH}.tar.gz

echo 'export PATH=/opt/cmake-'${VERSION}'-linux-'${ARCH}'/bin:$PATH' >> /etc/profile.d/cmake_path.sh

cd -

echo "[CMake Feature] Done"
