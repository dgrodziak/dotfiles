# Update dotfiles
function dfu
    cd ~/.dotfiles && git pull --ff-only && ./install -q
end

