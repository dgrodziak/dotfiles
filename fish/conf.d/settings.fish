# Enable vim-mode
fish_vi_key_bindings

# Enforce Ctrl+n to accept autosuggestions
bind -M insert \cN accept-autosuggestion
bind -M insert \cF forward-word

set -g fish_greeting ""

if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
else
    set -gx EDITOR vi
end
set -gx VISUAL $EDITOR
