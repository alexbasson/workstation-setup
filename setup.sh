#!/usr/bin/env bash
#
# setup.sh:  run the workstation setup
#

# Fail immediately if any errors occur
set -e

echo "Caching password..."
sudo -K
sudo true
clear

MY_DIR="$(cd "$(dirname "$0")" && pwd)"

# Note: Homebrew needs to be set up first
source "${MY_DIR}/scripts/common/homebrew.sh"

# Install everything else
source "${MY_DIR}/scripts/common/oh-my-zsh.sh"
source "${MY_DIR}/scripts/common/git.sh"
source "${MY_DIR}/scripts/common/git-aliases.sh"
source "${MY_DIR}/scripts/common/languages.sh"
source "${MY_DIR}/scripts/common/bun.sh"
source "${MY_DIR}/scripts/common/configuration-osx.sh"

source "${MY_DIR}/scripts/common/finished.sh"
