#!/bin/bash

set -e           # Exit if any command has non-zero exit code (return non-zero)
set -u           # Referencing undefined variables is an error
set -o pipefail  # Exit if any command in a pipeline fails (return last failed command's code)

# shellcheck source=/dev/null
DISTRO_ID="$(. /etc/os-release && echo "${ID}")"
readonly DISTRO_ID

if [[ "${DISTRO_ID,,}" != "ubuntu" ]]; then
  echo "install.sh: ubuntu distribution required: detected '${DISTRO_ID}'"
  exit 1
fi

# We can't interact with apt or dpkg when building the Dev Container
export DEBIAN_FRONTEND=noninteractive

apt-get update

# ROS requires a locale that supports UTF-8
# Docker images typically come with a POSIX locale
apt-get install --yes --quiet --no-install-recommends locales

locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

# ROS packages live in the `universe` repository
apt-get install --yes --quiet --no-install-recommends software-properties-common
add-apt-repository universe

apt-get install --yes --quiet --no-install-recommends curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg

# shellcheck source=/dev/null
echo "deb [arch=$(dpkg --print-architecture)" \
  "signed-by=/usr/share/keyrings/ros-archive-keyring.gpg]" \
  "http://packages.ros.org/ros2/ubuntu" \
  "$(. /etc/os-release && echo "${UBUNTU_CODENAME}") main" \
  | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Need to update again to get newly-added repo's package list
apt-get update

apt-get install --yes --quiet --no-install-recommends \
  ros-"${VERSION}"-ros-base \
  ros-dev-tools

# We should clean up after ourselves
rm -rf /var/lib/apt/lists/*
