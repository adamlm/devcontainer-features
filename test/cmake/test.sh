#!/bin/bash

set -e

source dev-container-features-test-lib

check "version" cmake --version

# Report result
reportResults
