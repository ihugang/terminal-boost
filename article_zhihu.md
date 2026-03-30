# 你的 Mac 终端还在用默认配置？这套工具让我效率翻倍

用了 Mac 好几年，终端一直是默认的 Terminal.app + 原生命令。直到某天搜代码等了快 10 秒，才意识到——我一直在用 1990 年代的工具干 2026 年的活。

折腾了一个下午，现在一条命令就能把终端武装好：

```bash
curl -fsSL https://raw.githubusercontent.com/ihugang/terminal-boost/main/install.sh | bash
```

脚本会自动安装并配置 12 个工具，核心替换逻辑很简单：

| 你现在用 | 换成 | 差别 |
|---------|------|------|
| `grep` | `rg`（ripgrep） | 快 10-50 倍，自动忽略 node_modules |
| `find` | `fd` | 语法简单 10 倍 |
| `cat` | `bat` | 自带语法高亮，看代码舒服多了 |
| `ls` | `eza` | 彩色 + 图标 + 显示 Git 状态 |
| `cd` | `z`（zoxide） | 学习你的习惯，`z proj` 直接跳常用目录 |
| `git diff` | `delta` | 并排对比，有行号，能看懂了 |

`lazygit` 是我用下来变化最大的——再也不用背 `git rebase -i HEAD~3` 这种命令，所有操作在 TUI 里点就行。

---

**但我觉得真正有意思的是另一件事。**

装完这些工具，我顺手写了一个 Claude Code 的 skill 文件放进了项目里。

`.claude/commands/terminal-boost.md` 这个文件的作用是：告诉 AI "你现在有这些工具可以用"。

以前让 Claude 帮我搜代码，它默认会写 `grep -r "xxx" .`。现在它知道系统装了 ripgrep，会直接写 `rg "xxx"`，还会加上 `-t js` 只搜 JS 文件、`-C 3` 显示上下文。

这个思路让我觉得挺有意思：**环境能力要显式声明给 AI，它才能真正用上。**

在任何项目里运行 `/terminal-boost`，AI 会自动检测哪些工具缺失、配置是否到位，并给出快速参考。有点像给 AI 做了一次"工具体检"。

---

项目开源在 GitHub：**ihugang/terminal-boost**

如果你也觉得终端该换代了，试试吧。
