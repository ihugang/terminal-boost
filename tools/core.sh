#!/usr/bin/env bash
# Core CLI tools — faster, smarter replacements for built-in commands
# Usage: bash tools/core.sh

set -e

TOOLS=(ripgrep fd fzf bat eza git-delta jq lazygit)

for tool in "${TOOLS[@]}"; do
  if brew list "$tool" &>/dev/null; then
    echo "✓ $tool already installed"
  else
    brew install "$tool" && echo "✓ $tool installed"
  fi
done

# fzf shell integration
if [[ ! -f "$HOME/.fzf.zsh" ]]; then
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
fi

echo "Core tools ready."
