# External plugins (initialized before)

# zsh-completions
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)

# Setup brew completions if available
if [[ -f "$(which brew)" ]]; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    fpath=("/home/linuxbrew/.linuxbrew/share/zsh/site-functions" $fpath)
fi 

