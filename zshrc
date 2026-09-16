# Functions
source ~/.shell/functions.sh

# External plugins (initialized before)
source ~/.zsh/plugins_before.zsh

# Settings
source ~/.zsh/settings.zsh

# Bootstrap
source ~/.shell/bootstrap.sh

# External settings
source ~/.shell/external.sh

# Aliases
source ~/.shell/aliases.sh

# Custom prompt
if command -v starship &> /dev/null; then
    if [ -s ~/.config/starship.local.toml ]; then
        export STARSHIP_CONFIG=~/.config/starship.local.toml
    else
        export STARSHIP_CONFIG=~/.config/starship.toml
    fi
    eval "$(starship init zsh)"
else
    source ~/.zsh/prompt.zsh
fi

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

# Allow local customizations (not checked in to version control)
if [ -f ~/.shell.local.sh ]; then
    source ~/.shell.local.sh
fi
