# 内容蒸馏 · baozangtuan77-content-distiller

> 把外部内容（课程 / 播客 / 博主系列 / 视频 / 长文）蒸馏成一份结构化笔记——**并映射到你自己的知识库和真实业务**。
>
> A config-driven skill that distills external content into structured notes **mapped to your own knowledge base and business** — not just another summarizer.

一个给 [Claude Code](https://claude.com/claude-code) / Agent 用的 skill。作者：**宝藏团七七**。

---

## 它和普通"摘要工具"有什么不一样

普通摘要工具给你一份"内容讲了啥"。这个工具多给你两层别处没有的东西：

1. **🔍 交叉对比** —— 把外部观点和你**已有的知识库**逐条对撞，分成四象限：
   - ✅ 共识（验证你对了）/ ⚠️ 相反（最值得警惕）/ 💡 盲区（最有价值）/ 📈 深化（你有但人家更透）
2. **🎯 业务映射** —— 把外部方法论落到你**具体的项目、产品功能、内容选题**，而不是泛泛而谈。

这两层靠一个 `config.yaml` 驱动：你把私有业务"声明"在配置里，引擎就从一个通用摘要器变成**懂你业务的私人内容参谋**。

> 没配置也能用——退化成一个干净的内容蒸馏器（框架/方法论/金句提取）。配置了才解锁上面两层。

---

## 快速开始

```bash
# 1. 把 skill 放进你的 skills 目录
git clone https://github.com/baozangtuan77/baozangtuan77-content-distiller.git
# 复制到 ~/.claude/skills/ 或 ~/.agents/skills/（按你的环境）

# 2. 配置你的业务（核心步骤）
cp config.example.yaml config.yaml
# 编辑 config.yaml，填你自己的知识库目录和业务维度
# config.yaml 已被 .gitignore，不会上传

# 3. 用
/content-distiller https://youtu.be/xxxx
/content-distiller "我刚听的这条 2 小时行业分享录音"
```

字段怎么填见 [`config.schema.md`](./config.schema.md)。

---

## 工作流程

```
输入（课程/博主系列/视频/长文）
  → 转写成文字（用你自己的 ASR 工具）
  → 5 维可蒸馏度评分（决定深度档/标准档/精简档）
  → 核心框架 + 方法论提取
  → 🔍 与你知识库交叉对比     ← config 驱动
  → 🎯 映射到你真实业务        ← config 驱动
  → 行动清单 + 金句 + 风险提示
  → 写入一份独立笔记
```

完整步骤见 [`SKILL.md`](./SKILL.md)。

> **第一次用、还没建 config？** skill 会先用几个问题访谈你，边问边把 `config.yaml` 建起来。**连知识库都还没有也行**——它会建议你先建哪几类"核心知识卡"，并用第一次蒸馏发现的盲区当种子，帮你把知识库攒起来。

---

## 看个例子

两份虚构示例，演示不同来源的产出长相：
- [`examples/sample-note-course.md`](./examples/sample-note-course.md) —— 单课程（深度档）
- [`examples/sample-note-blogger-series.md`](./examples/sample-note-blogger-series.md) —— 博主系列多条合并（标准档，带出处标注）

音视频怎么转文字（含**免费本地**方案）见 [`docs/transcription.md`](./docs/transcription.md)。

---

## 设计原则

- **提取不诠释**：原文没说的不脑补；作者断言没论据的明确标注
- **业务映射必须具体**：到项目、到文件、到版本号，抽象即无效
- **以你的知识库为权威基准**：不轻易用外部叙事倒推你的业务路径
- **私有信息留本地**：所有业务细节在 `config.yaml`，永不进仓库

---

## 关于配置示例

`config.example.yaml` 里用的是一个**虚构的"在线教育创业者"**做样板，方便你照着改。里面没有任何真实的人/公司/数据。

---

## License

MIT © 宝藏团七七（[baozangtuan77](https://github.com/baozangtuan77)）

蒸馏引擎的"提取不诠释 / 置信度标注 / 可蒸馏度评分"思路参考了开源社区的 distiller 类项目；本工具的差异化在 config 驱动的交叉对比 + 业务映射两层。
