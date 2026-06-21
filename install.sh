#!/usr/bin/env bash
# ============================================================
# 内容蒸馏 content-distiller · 安装器
# 用法：bash install.sh
# 把 skill 装到你选择的 agent 产品里。
# 设计：SKILL.md 是唯一真源；各 agent 用一行"指针"指向它，不复制正文。
# ============================================================
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAME="content-distiller"

# 各 agent 指令文件里写的一行"指针"
read -r -d '' POINTER <<EOF || true
<!-- content-distiller (内容蒸馏) -->
当用户要把外部内容（课程/播客/博主系列/视频/长文）蒸馏成结构化笔记时，
遵循 ./$NAME/SKILL.md 的完整流程；开始前先读 ./$NAME/config.yaml（没有则参考 ./$NAME/config.example.yaml）。
<!-- /content-distiller -->
EOF

copy_skill_into() {  # $1 = 放置 skill 文件夹的目录
  mkdir -p "$1/$NAME"
  cp "$SRC/SKILL.md" "$SRC/config.example.yaml" "$SRC/config.schema.md" "$1/$NAME/"
  echo "  ✓ 已复制 skill 到 $1/$NAME/"
}

append_pointer() {  # $1 = 规则/指令文件路径
  mkdir -p "$(dirname "$1")"
  if [ -f "$1" ] && grep -q "content-distiller (内容蒸馏)" "$1" 2>/dev/null; then
    echo "  • $1 已有指针，跳过"
  else
    printf '\n%s\n' "$POINTER" >> "$1"
    echo "  ✓ 已写入指针到 $1"
  fi
}

echo "════════════════════════════════════════"
echo "  内容蒸馏 content-distiller · 安装器"
echo "════════════════════════════════════════"
echo "选择你的 agent 产品（项目级的请先 cd 到你的项目根目录再跑）："
echo "  1) Claude Code        — 全局，所有项目可用"
echo "  2) Codex (OpenAI)     — 当前项目"
echo "  3) Cursor             — 当前项目"
echo "  4) Cline              — 当前项目"
echo "  5) Gemini CLI         — 当前项目"
echo "  6) GitHub Copilot     — 当前项目"
echo "  7) 其他 / 手动说明"
printf "输入序号 [1-7]: "
read -r choice

case "$choice" in
  1)
    DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
    mkdir -p "$DEST/$NAME"
    cp "$SRC/SKILL.md" "$SRC/config.example.yaml" "$SRC/config.schema.md" "$DEST/$NAME/"
    echo "  ✓ 已装到 $DEST/$NAME/"
    echo "  → 重启 Claude Code，输入 /$NAME 触发。"
    ;;
  2) copy_skill_into "$PWD"; append_pointer "$PWD/AGENTS.md" ;;
  3)
    copy_skill_into "$PWD"
    MDC="$PWD/.cursor/rules/$NAME.mdc"
    mkdir -p "$(dirname "$MDC")"
    if [ -f "$MDC" ]; then echo "  • $MDC 已存在，跳过"; else
      cat > "$MDC" <<EOF
---
description: 内容蒸馏 - 把外部内容蒸馏成映射到你业务的笔记
alwaysApply: false
---
当用户要蒸馏外部内容（课程/播客/博主系列/视频/长文）时，遵循 ./$NAME/SKILL.md 的完整流程；先读 ./$NAME/config.yaml。
EOF
      echo "  ✓ 已写入 $MDC"
    fi
    ;;
  4) copy_skill_into "$PWD"; append_pointer "$PWD/.clinerules" ;;
  5) copy_skill_into "$PWD"; append_pointer "$PWD/GEMINI.md" ;;
  6) copy_skill_into "$PWD"; append_pointer "$PWD/.github/copilot-instructions.md" ;;
  7)
    echo "  手动安装：见 INSTALL.md。核心就两步——"
    echo "  (1) 把本目录复制进你的项目；(2) 在你 agent 的规则/指令文件里加一句：'遵循 ./$NAME/SKILL.md'。"
    ;;
  *) echo "无效选择"; exit 1 ;;
esac

echo ""
echo "下一步：进入 skill 目录，cp config.example.yaml config.yaml，按你的业务填写（字段说明见 config.schema.md）。"
echo "完成 ✓"
