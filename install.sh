#!/usr/bin/env bash
# install.sh - wire starship-tableflip into Omarchy's theme rendering.
#
#   1. Drops starship.toml.tpl into ~/.config/omarchy/themed/, where Omarchy
#      renders it from the active theme's colors.toml on every
#      `omarchy theme set` (user templates render ahead of the built-ins).
#   2. Points ~/.config/starship.toml at the rendered output in
#      ~/.local/state/omarchy/current/theme/starship.toml.
#   3. Re-renders the current theme so the prompt applies immediately.
#
# On non-Omarchy systems it takes a simpler path:
#
#   1. Backs up any existing ~/.config/starship.toml.
#   2. Symlinks ~/.config/starship.toml at the repo's starship.toml
#      (git pull therefore updates the prompt).
#
# Existing files are backed up as <path>.bak.<epoch> before being replaced.
#
# Usage: ./install.sh [--copy]
#   --copy   copy the template instead of symlinking it (no live updates on git pull)

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="$REPO_DIR/starship.toml.tpl"

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

TEMPLATE_DEST="$CONFIG_HOME/omarchy/themed/starship.toml.tpl"
STARSHIP_CONFIG="$CONFIG_HOME/starship.toml"
RENDERED="$STATE_HOME/omarchy/current/theme/starship.toml"

fail() { echo "install.sh: $*" >&2; exit 1; }

usage() {
  cat <<USAGE
Usage: ./install.sh [--copy]

  --copy   copy the template instead of symlinking it
USAGE
}

MODE=link
case "${1:-}" in
  --copy) MODE=copy ;;
  -h | --help) usage; exit 0 ;;
  "") ;;
  *) fail "unknown option: $1" ;;
esac

OMARCHY=true
command -v omarchy >/dev/null 2>&1 || OMARCHY=false
[[ -f $TEMPLATE ]] || [[ $OMARCHY == false ]] || fail "template not found: $TEMPLATE"

backup() {
  local path="$1" dest
  [[ -e $path || -L $path ]] || return 0
  [[ -d $path && ! -L $path ]] && fail "$path is a directory; not touching it"
  dest="$path.bak.$(date +%s)"
  if [[ -f $path ]]; then
    cp -L "$path" "$dest"
    echo "Backed up $path -> $dest"
  else
    readlink "$path" >"$dest.link"
    echo "Noted symlink $path -> $(readlink "$path") in $dest.link"
  fi
}

if [[ $OMARCHY == false ]]; then
  # Non-Omarchy: back up any existing config and link the repo's starship.toml.
  REPO_CONFIG="$REPO_DIR/starship.toml"
  [[ -f $REPO_CONFIG ]] || fail "starship.toml not found: $REPO_CONFIG"
  if [[ -L $STARSHIP_CONFIG && $(readlink "$STARSHIP_CONFIG") == "$REPO_CONFIG" ]]; then
    echo "starship.toml already points at the repo."
  else
    backup "$STARSHIP_CONFIG"
    ln -sfn "$REPO_CONFIG" "$STARSHIP_CONFIG"
    echo "Linked $STARSHIP_CONFIG -> $REPO_CONFIG"
  fi
  cat <<DONE

Done -- open a new terminal to see it. (╯°□°）╯︵┻━┻
You're not on Omarchy, so the prompt is linked straight to the repo:
\`git pull\` updates it, and uninstall.sh restores your old config.
DONE
  exit 0
fi

# 1. Template into Omarchy's user themed directory.
mkdir -p "$(dirname "$TEMPLATE_DEST")"
if [[ $MODE == link ]]; then
  if [[ -L $TEMPLATE_DEST && $(readlink "$TEMPLATE_DEST") == "$TEMPLATE" ]]; then
    echo "Template link already in place: $TEMPLATE_DEST"
  else
    backup "$TEMPLATE_DEST"
    ln -sfn "$TEMPLATE" "$TEMPLATE_DEST"
    echo "Linked $TEMPLATE_DEST -> $TEMPLATE"
  fi
else
  if [[ -f $TEMPLATE_DEST && ! -L $TEMPLATE_DEST ]] && cmp -s "$TEMPLATE" "$TEMPLATE_DEST"; then
    echo "Template copy already in place: $TEMPLATE_DEST"
  else
    backup "$TEMPLATE_DEST"
    cp "$TEMPLATE" "$TEMPLATE_DEST"
    echo "Copied $TEMPLATE -> $TEMPLATE_DEST"
  fi
fi

# 2. Point starship at the rendered theme output.
if [[ -L $STARSHIP_CONFIG && $(readlink "$STARSHIP_CONFIG") == "$RENDERED" ]]; then
  echo "starship.toml already points at the rendered theme config."
else
  backup "$STARSHIP_CONFIG"
  ln -sfn "$RENDERED" "$STARSHIP_CONFIG"
  echo "Linked $STARSHIP_CONFIG -> $RENDERED"
fi

# 3. Render with the current theme.
echo "Rendering with current theme..."
omarchy theme refresh

if [[ -f $RENDERED ]] && ! grep -q '{{' "$RENDERED"; then
  cat <<DONE

Done -- open a new terminal to see it. (╯°□°）╯︵┻━┻
The prompt now follows your Omarchy theme: \`omarchy theme set <name>\` re-renders it.
DONE
else
  fail "rendered $RENDERED is missing or has unrendered tokens; check 'omarchy theme refresh' output"
fi
