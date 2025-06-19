# Load bash completion if it's installed and bash is not in POSIX mode
if ! shopt -oq posix; then
  # Modern install location
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  # Legacy install location
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
