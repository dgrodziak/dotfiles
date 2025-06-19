# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Python startup file
export PYTHONSTARTUP=$HOME/.pythonrc

# Setup brew environment if available
if [[ -f "$(which brew)" ]]; then
    eval "$(brew shellenv)"
    export HOMEBREW_NO_INSTALL_FROM_API=1
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export HOMEBREW_NO_INSTALL_FROM_API=1
fi 

# Add miniconda to the $PATH if available
if [[ -f ~/miniconda3/etc/profile.d/conda.sh ]]; then 
    . ~/miniconda3/etc/profile.d/conda.sh
fi 

# Add mssql-tools to $PATH if available
if [[ -d /opt/mssql-tools18/bin ]]; then
    export PATH="$PATH:/opt/mssql-tools18/bin"
fi

# Alias ls to eza if eza is installed
if command -v eza &> /dev/null; then
    alias ls='eza --git --group-directories-first'
else
    alias ls='ls --color=auto'
fi
