#!/bin/bash

set -e

source dev-container-features-test-lib

check "version" cmake --version | grep '3.27.4'

# Report result
reportResults
