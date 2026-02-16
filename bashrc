#!/usr/bin/env bash

# Functions
# shellcheck source=shell/functions.sh
source "${HOME}/.shell/functions.sh"

# Settings
# shellcheck source=bash/settings.bash
source "${HOME}/.bash/settings.bash"

# Boostrap
# shellcheck source=shell/bootstrap.sh
source "${HOME}/.shell/bootstrap.sh"

# External settings
# shellcheck source=shell/external.sh
source "${HOME}/.shell/external.sh"

# Aliases
# shellcheck source=shell/aliases.sh
source "${HOME}/.shell/aliases.sh"

# Custom prompt
# shellcheck source=bash/prompt.bash
source "${HOME}/.bash/prompt.bash"

# Plugins
# shellcheck source=bash/plugins.bash
source "${HOME}/.bash/plugins.bash"

# Allow local customizations (not checked in to version control)
if [ -f "${HOME}/.shell.local.sh" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.shell.local.sh"
fi
