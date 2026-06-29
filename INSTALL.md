# 安装指南（支持多种 agent）

这个 skill 的本质是**一份 markdown 指令（`SKILL.md`）+ 一个配置文件**。`SKILL.md` 是唯一真源，各 agent 用一行"指针"指向它——不复制正文，避免日后各处漂移。

下面三种方式任选,**推荐方式零**。

---

## 方式零：一行命令（最快，推荐）

```bash
npx skills add baozangtuan77/baozangtuan77-content-distiller
```

借助 [`skills` CLI](https://github.com/vercel-labs/skills) —— 一个支持 70+ 个 agent（Claude Code / Codex / Cursor / Cline / Gemini / Copilot / Windsurf 等）的通用安装器,它会自动判断你装了哪些 agent、按各家规矩装进对应目录。默认装到项目级,全局加 `-g`,跳过确认加 `-y`。

> ⚠️ **装完必做**：进 skill 目录 `cp config.example.yaml config.yaml` 填你的业务——`npx skills add` 只装 `SKILL.md`，不会替你做 config 这步。

---

## 方式一：一键脚本（会顺手帮你做 config）

```bash
git clone https://github.com/baozangtuan77/baozangtuan77-content-distiller.git
cd baozangtuan77-content-distiller
bash install.sh        # 按提示选你的 agent
```

> 装到**项目级** agent（Codex/Cursor/Cline/Gemini/Copilot）时，**先 `cd` 到你的项目根目录再跑脚本**。

装完别忘最后一步：进 skill 目录 `cp config.example.yaml config.yaml`，填你自己的业务（字段见 [`config.schema.md`](./config.schema.md)）。

---

## 方式二：手动安装（按你的 agent 看一节）

通用原理：把本仓库复制进你的项目（或 skill 目录），然后在你 agent 的指令文件里加一句"遵循 ./content-distiller/SKILL.md"。

### Claude Code（原生，全局可用）
```bash
cp -r baozangtuan77-content-distiller ~/.claude/skills/content-distiller
```
重启 Claude Code，输入 `/content-distiller` 即可触发。无需写指针——Claude 会自动发现。

### Codex (OpenAI)
1. 把本仓库复制进你的项目，如 `./content-distiller/`
2. 在项目根的 `AGENTS.md` 加一段：
   ```markdown
   当用户要蒸馏外部内容（课程/播客/博主系列/视频/长文）时，
   遵循 ./content-distiller/SKILL.md 的完整流程；先读 ./content-distiller/config.yaml。
   ```

### Cursor
1. 复制本仓库进项目 `./content-distiller/`
2. 新建 `.cursor/rules/content-distiller.mdc`：
   ```markdown
   ---
   description: 内容蒸馏 - 把外部内容蒸馏成映射到你业务的笔记
   alwaysApply: false
   ---
   当用户要蒸馏外部内容时，遵循 ./content-distiller/SKILL.md，先读 ./content-distiller/config.yaml。
   ```

### Cline
1. 复制本仓库进项目 `./content-distiller/`
2. 在 `.clinerules`（文件或 `.clinerules/` 目录里新建一条）写同样那句指针。

### Gemini CLI
1. 复制本仓库进项目 `./content-distiller/`
2. 在项目根 `GEMINI.md` 加那句指针。

### GitHub Copilot
1. 复制本仓库进项目 `./content-distiller/`
2. 在 `.github/copilot-instructions.md` 加那句指针。

### 任何其他 agent（Windsurf / Aider / Continue / 自研 …）
只要它能**读取本地文件**，就能用。把指令文件指向 `./content-distiller/SKILL.md` 即可——
触发方式从"斜杠命令"变成"你让它按这份说明做"，核心功能（蒸馏 + 读 config 映射业务）不变。

---

## 装完都要做的一步：配置

```bash
cd content-distiller           # 进入 skill 目录（路径按你装的位置）
cp config.example.yaml config.yaml
# 编辑 config.yaml，填你的知识库目录和业务维度（config.yaml 已 gitignore，不会上传）
```

字段说明见 [`config.schema.md`](./config.schema.md)。没有知识库也能用——首次运行时 skill 会引导你建档、并建议你先建哪几类核心知识卡。
