# terminal-boost

> 一条命令，让你的 Mac 终端脱胎换骨。

```bash
curl -fsSL https://raw.githubusercontent.com/hugang/terminal-boost/main/install.sh | bash
```

---

## 安装了什么

### 核心工具 — 替换内置慢命令

| 工具 | 替代 | 原因 |
|------|------|------|
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) | `grep` | 快 10–50 倍，自动忽略 `.gitignore` |
| [fd](https://github.com/sharkdp/fd) | `find` | 语法更简单，速度更快 |
| [fzf](https://github.com/junegunn/fzf) | — | 模糊搜索神器，搜文件/历史命令 |
| [bat](https://github.com/sharkdp/bat) | `cat` | 语法高亮 + Git 集成 |
| [eza](https://github.com/eza-community/eza) | `ls` | 彩色输出、图标、Git 状态 |
| [delta](https://github.com/dandavison/delta) | `git diff` | 并排对比、语法高亮的 diff |
| [jq](https://github.com/jqlang/jq) | — | 命令行 JSON 处理 |
| [lazygit](https://github.com/jesseduffield/lazygit) | — | 可视化 Git TUI，告别记命令 |

### 进阶工具 — 效率升级

| 工具 | 功能 |
|------|------|
| [zoxide](https://github.com/ajeetdsouza/zoxide) | 智能 `cd`，`z proj` 直接跳到常用目录 |
| [atuin](https://github.com/atuinsh/atuin) | 历史命令存入数据库，`Ctrl+R` 全面升级 |
| [btop](https://github.com/aristocratos/btop) | 好看的系统监控（CPU/内存/网络） |
| [dust](https://github.com/bootandy/dust) | 可视化磁盘占用，树状显示 |

---

## 自动配置了什么

- **Shell 别名**写入 `~/.zshrc`：
  - `ls` → `eza --icons`
  - `ll` → `eza -la --icons --git`
  - `lt` → `eza --tree --level=2`
  - `cat` → `bat`
  - `z <目录>` → zoxide 智能跳转
  - `Ctrl+R` → atuin 历史搜索

- **Git** 配置为用 `delta` 渲染所有 diff（并排显示、行号）

安装前会自动备份你的 `~/.zshrc` 和 `~/.gitconfig`，放心使用。

---

## 选装

只装你需要的：

```bash
# 只装核心工具
bash tools/core.sh

# 只装进阶工具
bash tools/power.sh
```

或者手动复制配置片段：

- [`configs/zshrc.snippet`](configs/zshrc.snippet) → 粘贴到 `~/.zshrc`
- [`configs/gitconfig.snippet`](configs/gitconfig.snippet) → 粘贴到 `~/.gitconfig`

---

## 常用速查

```bash
rg "TODO"              # 递归搜索文件内容
fd config              # 按文件名查找
bat README.md          # 带语法高亮查看文件
ll                     # 列出文件（带详情 + git 状态）
z projects             # 跳转到常用目录
lazygit                # 可视化 git，按 ? 查看帮助
git diff               # 自动用 delta 渲染
btop                   # 系统监控
dust                   # 磁盘占用分析
```

---

## 系统要求

- macOS（Apple Silicon 或 Intel）
- [Homebrew](https://brew.sh)（没有会自动安装）

Linux 支持规划中。

---

## License

MIT
