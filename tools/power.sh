#!/usr/bin/env bash
# Power tools — directory jumping, history, monitoring, disk analysis
# Usage: bash tools/power.sh

set -e

TOOLS=(zoxide atuin btop dust)

for tool in "${TOOLS[@]}"; do
  if brew list "$tool" &>/dev/null; then
    echo "✓ $tool already installed"
  else
    brew install "$tool" && echo "✓ $tool installed"
  fi
done

echo "Power tools ready."
