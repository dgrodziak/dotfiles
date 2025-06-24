# Although this is better located in external.fish, we need it to be sourced before the other aliases
if type -q eza
    alias ls='eza --git --group-directories-first'
else
    alias ls='ls --color=auto'
end

# Aliases
source ~/.shell/aliases.sh

# Local configs (not in git)
source ~/.shell_local
