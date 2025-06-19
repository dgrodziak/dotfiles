# Dotfiles 

## Getting Started

```sh
git clone https://github.com/dgrodziak/dotfiles.git
# [Optional] Checkout branch for machine/group-specific configurations. See "Local Customizations" below.
./install
```

Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Local Customizations

Local customizations for some progams can be made by editing these files:
* `vim`: `~/.vimrc_local`
* `zsh` / `bash`: `~/.shell_local_before` run first
* `zsh`: `~/.zshrc_local_before` run before `zshrc`
* `zsh`: `~/.zshrc_local_after` run after `zshrc`
* `zsh` / `bash`: `~/.shell_local_after` run last
* `git`: `~/.gitconfig_local`
* `ssh`: `~/ssh/config_local`

Note: for the main color scheme to look right, machine- and terminal-specific support is likely to be needed. Use local customizations for such configurations.

## Branch Hierarchy

Custom configurations, as needed, are maintained in separate branches in this repo.

```
master
|
+- mac
|
+- windows
```
