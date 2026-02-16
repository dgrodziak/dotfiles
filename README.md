# Dotfiles

## Getting Started

```sh
git clone https://github.com/dgrodziak/dotfiles.git
# [Optional] Checkout branch for machine/group-specific configurations. See "Local Customizations" below.
./install
```

Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Prerequisites

Required:

- `git`
- One or more shells you use (`bash`, `zsh`, and/or `fish`)

Optional but referenced by configs:

- `tmux`
- `neovim`
- `starship`
- `eza`
- `xclip` (Linux clipboard integration for tmux)
- Homebrew (`brew`) on macOS/Linux

## Local Customizations

Local customizations can be made by adding `.local` to the name. For example:

- `git`: `~/.gitconfig.local`
- `zsh` / `bash`: `~/.shell.local.sh`
- `fish`: `~/.shell.local.fish`
- `ssh`: `~/.ssh/config.local`

## Branch Hierarchy

Custom configurations, as needed, are maintained in separate branches in this repo.

```
master
|
+- windows
```
