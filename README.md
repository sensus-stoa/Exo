# ExoCortex — Personal AI Operating System

> 🇷🇺 [Русская версия](README.ru.md)

A personal AI journal pipeline: dictate → transcribe → AI analysis → behavioral hypotheses → tomorrow's tasks.

500+ hypotheses in 3.5 months. 30 turned out to be true. Most of them I didn't want to know.

## What's inside

| File | Purpose |
|------|---------|
| `AGENTS.md` | System prompt for AI — philosophy, cognitive protocols, anti-sycophancy |
| `PIPELINE.md` | Processing contours (C1-C4) and AI-to-journal interaction rules |
| `DailyLogTemplate.md` | Daily report template v8.4 |
| `examples/daily_report.md` | Demo report (fictional) |
| `examples/metrics.jsonl` | Metrics storage format |
| `core/` | System skeleton: goals, patterns, hypotheses, calibration |
| `attractors/` | Behavioral attractors concept |

## Quick start

1. Copy `DailyLogTemplate.md` — your template
2. Copy `AGENTS.md` — your AI instructions
3. Dictate your day in the evening (15-20 min)
4. Feed to AI (DeepSeek, Claude, local LLM — any)
5. AI fills the template, writes hypotheses, sets tasks

## Requirements

- Python 3.10+ (for transcription)
- GigaAM or Whisper (voice transcription)
- DeepSeek API / Claude API / local LLM (analysis)

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
