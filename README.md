# ExoCortex — Personal AI Operating System

> 🇷🇺 [Русская версия](README.ru.md)

A personal AI journal pipeline: dictate → transcribe → AI analysis → behavioral hypotheses → tomorrow's tasks.

500+ hypotheses in 3.5 months. 30 turned out to be true. Most of them I didn't want to know.

## Quick start

```bash
# 1. Clone
git clone https://github.com/sensus-stoa/Exo.git
cd Exo

# 2. Initial setup
bash exo-init.sh
# — tells which metrics you track
# — whether you need goals system
# — saves config.json

# 3. Record your day (15-20 min)
# Voice:     send to AI agent, it transcribes via GigaAM
# Text:      just write raw notes

# 4. Run C1 (Daily analysis)
# Feed your raw text to any AI with AGENTS.md as system prompt.
# AI fills DailyLogTemplate, writes hypotheses, sets tomorrow's tasks.
```

## What's inside

| File | Purpose |
|------|---------|
| `AGENTS.md` ([RU](AGENTS.ru.md)) | System prompt for AI — philosophy, cognitive protocols, anti-sycophancy |
| `PIPELINE.md` ([RU](PIPELINE.ru.md)) | Processing contours (C1-C4) and AI-to-journal interaction rules |
| `DailyLogTemplate.md` ([RU](DailyLogTemplate.ru.md)) | Daily report template v8.4 |
| `examples/daily_report.md` | Demo report (fictional) |
| `examples/metrics.jsonl` | Metrics storage format |
| `core/` | System skeleton: goals, patterns, hypotheses, calibration |
| `attractors/` | Behavioral attractors concept |

Each `.md` file has a `.ru.md` counterpart with the Russian version. Default is English.

## How it works

```
Voice (m4a) → GigaAM/Whisper (local STT) → raw .md
→ AI reads AGENTS.md + template
→ fills metrics, finds patterns, writes hypotheses
→ sets tomorrow's tasks
→ commits to git
```

**Daily:** signal detection, metric tracking, directive feedback loop  
**Weekly:** hypothesis distillation, blind spot audit, goal velocity  
**Monthly:** cross-domain correlation, trajectory deviation check  
**Quarterly:** strategic deep dive, development vectors

## Why

Most AI note-taking apps store your thoughts. ExoCortex **analyzes** them. It finds patterns you can't see because you're inside them. It's not a second brain — it's an external neocortex.

No flattery. The system prompt explicitly forbids praise and demands brutal honesty. It's configured to disagree with you by default.

## Article

Full breakdown (Russian): Habr article — «How I built a system that knows me better than I do»

## License

MIT — do whatever. If you collect data from multiple people, that would be awesome.
