# 转录：把音视频变成文字

content-distiller 从"已有文字"开始。所以分两步：先把内容拿到手，再（如果是音视频）转成文字。

## 第一步：先把内容拿到手

看你的输入是什么：

- **本地音频 / 视频文件**：直接进第二步转录。
- **粘贴文本 / 已有逐字稿**：不用转录，直接喂给 skill。
- **文章链接**（公众号 / 博客）：让你的 agent 用网页抓取（WebFetch / 浏览器）取正文，不用转录。
- **视频链接**（YouTube / B站…）：先用 [yt-dlp](https://github.com/yt-dlp/yt-dlp) 把音频抠出来，再转录。
  ```bash
  yt-dlp -x --audio-format mp3 "视频链接"   # 抠出音频，再丢给下面的 Whisper
  ```
- **平台链接**（小红书 / 抖音…）：这些平台不开放抓取，得用你自己的方式（登录态 / 第三方工具 / 手动复制文案 + 下载视频）。skill 不负责破解平台，它只做"拿到文字之后"的蒸馏。

## 第二步：把音视频转成文字（选一个工具）

### 免费 / 本地（推荐个人用，0 成本）

- **Whisper（OpenAI 开源版）**：开源、本地跑、完全免费，中文识别不错。
  ```bash
  pip install -U openai-whisper
  whisper 录音.m4a --language Chinese --model medium
  ```
- **faster-whisper**：Whisper 的加速版，CPU 也能跑，长音频快很多。GitHub：`SYSTRAN/faster-whisper`。
- **whisper.cpp**：纯 C++ 实现，Mac/树莓派都能跑，省内存。GitHub：`ggerganov/whisper.cpp`。
- **MacWhisper（Mac 图形界面）**：拖进去就转，有免费档，适合不想碰命令行的人。

> 一句话：**不装通义也完全没问题**，本地 Whisper 免费、离线、隐私不出本机。

### 云端 / 付费（更省心，几乎不要钱）

- **OpenAI Whisper API**：约 $0.006/分钟（1 小时音频 ~$0.36），无需本地配置，调一个接口就行。
- **通义听悟**：中文长音频体验好，有免费额度（作者本人常用）。
- **国内各家 ASR**（讯飞、腾讯云、百度等）：都有免费额度，按量付费很便宜。

## 给本 skill 的两个提醒

1. **转录稿不需要完美**——蒸馏会自动过滤废话、寒暄、广告。
2. **人名 / 专业术语的音译错误要手改**——ASR 常把人名听错（如把 "Eden" 听成 "eating"），不改会污染笔记里的讲师信息和方法论名称。

转录完成后，把文字喂给 `/content-distiller`：可以直接粘贴文本，或给一个本地 `.txt` 路径。
