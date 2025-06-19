# Functions
source ~/.shell/functions.sh

# Settings
source ~/.bash/settings.bash

# Boostrap
source ~/.shell/bootstrap.sh

# External settings
source ~/.shell/external.sh

# Aliases
source ~/.shell/aliases.sh

# Custom prompt
source ~/.bash/prompt.bash

# Plugins
source ~/.bash/plugins.bash

# Allow local customizations (not checked in to version control)
if [ -f ~/.shell_local ]; then
    source ~/.shell_local
fi

