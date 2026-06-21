# 转录：把音视频变成文字

content-distiller 从"已有文字"开始。音频 / 视频要先转成文字再喂给它。用什么工具都行——下面从**免费**到付费给几个选项，没装过任何转录工具也能上手。

## 免费 / 本地（推荐个人用，0 成本）

- **Whisper（OpenAI 开源版）**：开源、本地跑、完全免费，中文识别不错。
  ```bash
  pip install -U openai-whisper
  whisper 录音.m4a --language Chinese --model medium
  ```
- **faster-whisper**：Whisper 的加速版，CPU 也能跑，长音频快很多。GitHub：`SYSTRAN/faster-whisper`。
- **whisper.cpp**：纯 C++ 实现，Mac/树莓派都能跑，省内存。GitHub：`ggerganov/whisper.cpp`。
- **MacWhisper（Mac 图形界面）**：拖进去就转，有免费档，适合不想碰命令行的人。

> 一句话：**不装通义也完全没问题**，本地 Whisper 免费、离线、隐私不出本机。

## 云端 / 付费（更省心，几乎不要钱）

- **OpenAI Whisper API**：约 $0.006/分钟（1 小时音频 ~$0.36），无需本地配置，调一个接口就行。
- **通义听悟**：中文长音频体验好，有免费额度（作者本人常用）。
- **国内各家 ASR**（讯飞、腾讯云、百度等）：都有免费额度，按量付费很便宜。

## 给本 skill 的两个提醒

1. **转录稿不需要完美**——蒸馏会自动过滤废话、寒暄、广告。
2. **人名 / 专业术语的音译错误要手改**——ASR 常把人名听错（如把 "Eden" 听成 "eating"），不改会污染笔记里的讲师信息和方法论名称。

转录完成后，把文字喂给 `/content-distiller`：可以直接粘贴文本，或给一个本地 `.txt` 路径。
