# terminal-boost

> One command to turn your Mac terminal from default to delightful.

```bash
curl -fsSL https://raw.githubusercontent.com/hugang/terminal-boost/main/install.sh | bash
```

---

## What gets installed

### Core tools — smarter replacements for built-ins

| Tool | Replaces | Why |
|------|----------|-----|
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) | `grep` | 10–50× faster, respects `.gitignore` |
| [fd](https://github.com/sharkdp/fd) | `find` | Simpler syntax, faster |
| [fzf](https://github.com/junegunn/fzf) | — | Fuzzy finder for files, history, anything |
| [bat](https://github.com/sharkdp/bat) | `cat` | Syntax highlighting + Git integration |
| [eza](https://github.com/eza-community/eza) | `ls` | Colors, icons, Git status |
| [delta](https://github.com/dandavison/delta) | `git diff` | Side-by-side, syntax-highlighted diffs |
| [jq](https://github.com/jqlang/jq) | — | JSON filtering and formatting |
| [lazygit](https://github.com/jesseduffield/lazygit) | — | Visual Git TUI — no more memorizing flags |

### Power tools — productivity upgrades

| Tool | What it does |
|------|-------------|
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` — `z proj` jumps to your most-used dirs |
| [atuin](https://github.com/atuinsh/atuin) | Shell history as a searchable database, `Ctrl+R` upgraded |
| [btop](https://github.com/aristocratos/btop) | Beautiful system monitor (CPU, memory, network) |
| [dust](https://github.com/bootandy/dust) | Visual disk usage, shows what's eating your space |

---

## What gets configured

- **Shell aliases** added to `~/.zshrc`:
  - `ls` → `eza --icons`
  - `ll` → `eza -la --icons --git`
  - `lt` → `eza --tree --level=2`
  - `cat` → `bat`
  - `z <dir>` → zoxide smart jump
  - `Ctrl+R` → atuin history search

- **Git** configured to use `delta` for all diffs (side-by-side, line numbers)

Your existing `~/.zshrc` and `~/.gitconfig` are backed up before any changes.

---

## Manual / selective install

Install only what you want:

```bash
# Core tools only
bash tools/core.sh

# Power tools only
bash tools/power.sh
```

Or copy snippets manually:

- [`configs/zshrc.snippet`](configs/zshrc.snippet) → paste into `~/.zshrc`
- [`configs/gitconfig.snippet`](configs/gitconfig.snippet) → paste into `~/.gitconfig`

---

## Quick reference

```bash
rg "TODO"              # search file contents recursively
fd config              # find files by name
fzf                    # fuzzy find anything
bat README.md          # view file with syntax highlighting
ll                     # list files with details + git status
z projects             # jump to ~/Projects (or wherever you go most)
lazygit                # visual git — press ? for help
git diff               # automatically rendered by delta
btop                   # system monitor
dust                   # disk usage
```

---

## Requirements

- macOS (Apple Silicon or Intel)
- [Homebrew](https://brew.sh) (installed automatically if missing)

Linux support is planned.

---

## License

MIT
