---
description: Check, install, and manage terminal-boost CLI tools on macOS
---

You are helping the user manage their terminal-boost CLI toolset on macOS.

Run the following bash command to check the current state of all tools:

```bash
echo "=== Core Tools ===" && \
for t in rg fd fzf bat eza delta jq lazygit; do
  path=$(which $t 2>/dev/null)
  if brew list "${t/delta/git-delta}" &>/dev/null 2>&1 || command -v "$t" &>/dev/null; then
    version=$(${t} --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+\.?[0-9]*' | head -1)
    echo "✅ $t $version"
  else
    echo "❌ $t (not installed)"
  fi
done && \
echo "" && echo "=== Power Tools ===" && \
for t in zoxide atuin btop dust; do
  if brew list "$t" &>/dev/null 2>&1; then
    version=$($t --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+\.?[0-9]*' | head -1)
    echo "✅ $t $version"
  else
    echo "❌ $t (not installed)"
  fi
done && \
echo "" && echo "=== Shell Config ===" && \
grep -q "terminal-boost" ~/.zshrc 2>/dev/null && echo "✅ ~/.zshrc configured" || echo "❌ ~/.zshrc not configured" && \
grep -q "pager = delta" ~/.gitconfig 2>/dev/null && echo "✅ ~/.gitconfig configured" || echo "❌ ~/.gitconfig not configured"
```

Then:

1. Report the status clearly in a table — show ✅ installed (with version) and ❌ missing tools.

2. If any tools are **missing**, ask the user: "要安装缺失的工具吗？" If yes, install them with:
   - Missing core tools: `brew install <tool>` (use `git-delta` for delta)
   - After installing fzf: run `$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish`

3. If **shell config** is missing, ask if they want to add it, then append to `~/.zshrc`:
   ```
   # ── terminal-boost ──────────────────────────────────────────────────────────
   alias ls="eza --icons"
   alias ll="eza -la --icons --git"
   alias lt="eza --tree --level=2 --icons"
   alias cat="bat --paging=never"
   eval "$(zoxide init zsh)"
   eval "$(atuin init zsh)"
   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
   # ────────────────────────────────────────────────────────────────────────────
   ```

4. If **git config** is missing, ask if they want to add delta, then append to `~/.gitconfig`:
   ```
   [core]
       pager = delta
   [delta]
       side-by-side = true
       line-numbers = true
   [interactive]
       diffFilter = delta --color-only
   ```

5. After all checks/installs, show a **quick reference** in a compact table:

   | Command | What it does |
   |---------|-------------|
   | `rg "text"` | Search file contents (fast grep) |
   | `fd name` | Find files by name |
   | `ll` | List files with details + git status |
   | `cat file` | View file with syntax highlighting |
   | `z <dir>` | Smart jump to frequent directory |
   | `Ctrl+R` | Fuzzy search shell history (atuin) |
   | `lazygit` | Visual Git TUI |
   | `git diff` | Auto-rendered by delta |
   | `btop` | System monitor |
   | `dust` | Disk usage visualizer |

Always respond in Chinese (中文) unless the user writes in English.
