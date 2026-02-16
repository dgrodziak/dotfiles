# Dotfiles

## Getting Started

```sh
git clone https://github.com/dgrodziak/dotfiles.git
./install
```

Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Linting and Formatting

This repository uses [`prek`](https://github.com/j178/prek) for pre-commit hooks and CI checks.

```sh
prek install
prek run --all-files
```

## Local Customizations

Local customizations can be made by adding `.local` to the name. For example:

- `git`: `~/.gitconfig.local`
- `zsh` / `bash`: `~/.shell.local.sh`
- `fish`: `~/.shell.local.fish`
- `starship`: `~/.config/starship.local.toml`
- `ssh`: `~/.ssh/config.local`

## Branch Hierarchy

Custom configurations, as needed, are maintained in separate branches in this repo.

```
master
|
+- windows
```
