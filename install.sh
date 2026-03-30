#!/usr/bin/env bash
set -e

BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

print_step()  { echo -e "\n${BOLD}${CYAN}▶ $1${RESET}"; }
print_ok()    { echo -e "  ${GREEN}✓${RESET} $1"; }
print_warn()  { echo -e "  ${YELLOW}!${RESET} $1"; }

SHELL_RC="$HOME/.zshrc"
GITCONFIG="$HOME/.gitconfig"
BACKUP_SUFFIX=".terminal-boost-backup-$(date +%Y%m%d%H%M%S)"

# ── OS check ────────────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Only macOS is supported for now. Linux support is coming soon."
  exit 1
fi

echo -e "${BOLD}"
echo "╔═══════════════════════════════════╗"
echo "║        terminal-boost setup       ║"
echo "╚═══════════════════════════════════╝"
echo -e "${RESET}"

# ── Homebrew ─────────────────────────────────────────────────────────────────
print_step "Checking Homebrew"
if ! command -v brew &>/dev/null; then
  print_warn "Homebrew not found — installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  print_ok "Homebrew already installed"
fi

# ── Core tools ────────────────────────────────────────────────────────────────
print_step "Installing core tools"
CORE_TOOLS=(ripgrep fd fzf bat eza git-delta jq lazygit)
for tool in "${CORE_TOOLS[@]}"; do
  if brew list "$tool" &>/dev/null; then
    print_ok "$tool already installed"
  else
    brew install "$tool" &>/dev/null && print_ok "$tool installed"
  fi
done

# fzf shell integration
if [[ ! -f "$HOME/.fzf.zsh" ]]; then
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish &>/dev/null
  print_ok "fzf shell integration enabled"
fi

# ── Power tools ───────────────────────────────────────────────────────────────
print_step "Installing power tools"
POWER_TOOLS=(zoxide atuin btop dust)
for tool in "${POWER_TOOLS[@]}"; do
  if brew list "$tool" &>/dev/null; then
    print_ok "$tool already installed"
  else
    brew install "$tool" &>/dev/null && print_ok "$tool installed"
  fi
done

# ── Shell config (.zshrc) ─────────────────────────────────────────────────────
print_step "Configuring shell ($SHELL_RC)"

ZSHRC_BLOCK='
# ── terminal-boost ──────────────────────────────────────────────────────────
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --level=2 --icons"
alias cat="bat --paging=never"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ────────────────────────────────────────────────────────────────────────────'

if grep -q "terminal-boost" "$SHELL_RC" 2>/dev/null; then
  print_ok "Shell config already patched — skipping"
else
  cp "$SHELL_RC" "${SHELL_RC}${BACKUP_SUFFIX}" 2>/dev/null && print_ok "Backed up $SHELL_RC"
  echo "$ZSHRC_BLOCK" >> "$SHELL_RC"
  print_ok "Aliases and integrations added to $SHELL_RC"
fi

# ── Git config (.gitconfig) ───────────────────────────────────────────────────
print_step "Configuring git (delta diff)"

if grep -q "pager = delta" "$GITCONFIG" 2>/dev/null; then
  print_ok "Git delta already configured — skipping"
else
  cp "$GITCONFIG" "${GITCONFIG}${BACKUP_SUFFIX}" 2>/dev/null && print_ok "Backed up $GITCONFIG"
  cat >> "$GITCONFIG" <<'EOF'

# terminal-boost
[core]
	pager = delta
[delta]
	side-by-side = true
	line-numbers = true
[interactive]
	diffFilter = delta --color-only
EOF
  print_ok "Git delta configured"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo -e "\n${BOLD}${GREEN}All done!${RESET} Restart your terminal or run:  ${BOLD}source ~/.zshrc${RESET}\n"
echo "Installed tools:"
echo "  rg (ripgrep)  fd  fzf  bat  eza  delta  jq  lazygit"
echo "  zoxide  atuin  btop  dust"
echo ""
echo "Quick reference:"
echo "  ls / ll / lt  →  eza (better ls)"
echo "  cat           →  bat (syntax highlight)"
echo "  z <dir>       →  zoxide (smart cd)"
echo "  Ctrl+R        →  atuin (history search)"
echo "  lazygit       →  visual git TUI"
echo "  btop          →  system monitor"
echo "  dust          →  disk usage"
