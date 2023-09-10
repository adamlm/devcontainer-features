#!/bin/bash

set -e

source dev-container-features-test-lib

check "version" cmake --version | grep '3.26.5'

# Report result
reportResults
