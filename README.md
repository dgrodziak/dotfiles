# Dotfiles 

## Getting Started

```sh
git clone https://github.com/dgrodziak/dotfiles.git
# [Optional] Checkout branch for machine/group-specific configurations. See "Local Customizations" below.
./install.ps1
```

Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Local Customizations

Local customizations for some progams can be made by editing these files:
* `git`: `~/.gitconfig_local`
* `zsh` / `bash`: `~/.shell_local`
* `ssh`: `~/ssh/config_local`

## Branch Hierarchy

Custom configurations, as needed, are maintained in separate branches in this repo.

```
master
|
+- windows
```
