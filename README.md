# starship-tableflip

My (╯°□°）╯︵┻━┻ prompt for [starship](https://starship.rs), themed live by [Omarchy](https://omarchy.org) — or symlinked straight from the repo on any other system.

![Tableflip Screenshot](images/starship-tableflip.png)

## How it works

This is an Omarchy *themed template*, not a shell plugin (those are Quickshell
bar widgets). `starship.toml.tpl` is dropped into `~/.config/omarchy/themed/`,
where Omarchy renders its `{{ color }}` palette tokens from the active theme's
`colors.toml` on every `omarchy theme set` — so the prompt restyles itself
whenever you switch themes. `~/.config/starship.toml` points at the rendered
output in `~/.local/state/omarchy/current/theme/starship.toml`.

Styles reference the generic palette names (`fg:accent`, `bg:dark_background`,
`fg:muted`, ...) rather than any one theme's color names, so the config works
with every Omarchy theme and the palette section doubles as an overview of the
tokens you can use while tweaking.

On non-Omarchy systems, `~/.config/starship.toml` is simply symlinked to the
repo's `starship.toml`, so `git pull` updates the prompt (no live theming).

## Requirements

- [starship](https://starship.rs)
- a [Nerd Font](https://www.nerdfonts.com) for the prompt's icons/symbols
- [Omarchy](https://omarchy.org) (ships starship and a Nerd Font by default) — optional

## Install

```bash
git clone https://github.com/d34dh0r53/starship-tableflip.git
cd starship-tableflip
./install.sh
```

`install.sh`:

- backs up your existing `~/.config/starship.toml` (as `starship.toml.bak.<epoch>`)
- on **Omarchy**:
  - links `starship.toml.tpl` into `~/.config/omarchy/themed/` (use `./install.sh --copy` to copy instead)
  - links `~/.config/starship.toml` to the rendered theme output
  - runs `omarchy theme refresh` so it applies immediately
- on **other systems**:
  - links `~/.config/starship.toml` to this repo's `starship.toml`

## Update

```bash
git pull && ./install.sh
```

On Omarchy with the default symlink install, template changes apply on the next
`omarchy theme set` (or `omarchy theme refresh`); a `--copy` install needs the
re-run of `install.sh`. On other systems `git pull` alone is enough.

## Uninstall

```bash
./uninstall.sh
```

Removes the template and the `~/.config/starship.toml` link, then restores the
stock Omarchy prompt via `omarchy refresh config starship.toml`. On other
systems it removes the symlink and restores the newest install-time backup
(`starship.toml.bak.<epoch>` in `~/.config/`) if there was a previous config.
Install-time backups are left in `~/.config/` if you want your old config back
instead.
