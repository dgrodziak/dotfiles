# Setup brew environment if available
if type -q brew
    export HOMEBREW_NO_INSTALL_FROM_API=1
else if type -q /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export HOMEBREW_NO_INSTALL_FROM_API=1
end

# Custom prompt
if type -q starship
    starship init fish | source
end
