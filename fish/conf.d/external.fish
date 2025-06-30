# Setup brew environment if available
if type -q brew
    brew shellenv | source
    if test -d (brew --prefix)/share/fish/vendor_completions.d
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
else if type -q /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    if test -d (/home/linuxbrew/.linuxbrew/bin/brew --prefix)/share/fish/vendor_completions.d
        set -p fish_complete_path (/home/linuxbrew/.linuxbrew/bin/brew  --prefix)/share/fish/vendor_completions.d
    end
end

# Custom prompt
if type -q starship
    starship init fish | source
end
