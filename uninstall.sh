#!/usr/bin/env bash
# uninstall.sh - remove starship-tableflip and restore the stock Omarchy prompt.
#
#   1. Removes ~/.config/omarchy/themed/starship.toml.tpl if it was installed
#      by this repo (link into it, or a byte-identical copy).
#   2. Removes the ~/.config/starship.toml link into Omarchy state.
#   3. Restores the stock prompt with `omarchy refresh config starship.toml`
#      (which keeps its own backup).
#
# Backups made by install.sh (<path>.bak.<epoch>) are left in place.

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

TEMPLATE_DEST="$CONFIG_HOME/omarchy/themed/starship.toml.tpl"
STARSHIP_CONFIG="$CONFIG_HOME/starship.toml"
RENDERED="$STATE_HOME/omarchy/current/theme/starship.toml"

command -v omarchy >/dev/null 2>&1 || { echo "uninstall.sh: omarchy not found on PATH" >&2; exit 1; }

# 1. Template. Only remove what install.sh put there.
if [[ -L $TEMPLATE_DEST && $(readlink "$TEMPLATE_DEST") == "$REPO_DIR/starship.toml.tpl" ]]; then
  rm "$TEMPLATE_DEST"
  echo "Removed $TEMPLATE_DEST"
elif [[ -f $TEMPLATE_DEST && ! -L $TEMPLATE_DEST ]] && cmp -s "$REPO_DIR/starship.toml.tpl" "$TEMPLATE_DEST"; then
  rm "$TEMPLATE_DEST"
  echo "Removed $TEMPLATE_DEST"
elif [[ -e $TEMPLATE_DEST || -L $TEMPLATE_DEST ]]; then
  echo "Leaving $TEMPLATE_DEST (not installed by starship-tableflip)"
fi

# 2. starship.toml link. Omarchy checks -f through the link, so remove it
#    before refreshing or the render state file would be overwritten.
if [[ -L $STARSHIP_CONFIG && $(readlink "$STARSHIP_CONFIG") == "$RENDERED" ]]; then
  rm "$STARSHIP_CONFIG"
  echo "Removed $STARSHIP_CONFIG"
fi

# 3. Restore the stock Omarchy prompt.
if [[ ! -e $STARSHIP_CONFIG && ! -L $STARSHIP_CONFIG ]]; then
  omarchy refresh config starship.toml
fi

echo "Done -- stock Omarchy prompt restored. ┬──┬ ノ( ゜-゜ノ)"
