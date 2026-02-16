HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
shopt -s histappend # append to history file

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
elif command -v vim >/dev/null 2>&1; then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export VISUAL="$EDITOR"
