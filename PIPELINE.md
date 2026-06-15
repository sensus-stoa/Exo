# ExoCortex — Processing Pipeline

> This supplements `AGENTS.md`. AGENTS.md has the philosophy and protocols. This file has the processing mechanics.

## Processing Contours

The system runs in cycles of varying depth:

| Contour | Period | Purpose | Depth |
|---------|--------|---------|-------|
| **C1 — Daily** | Every day | AI reads raw report → metrics → hypotheses → tomorrow's directive | Operational |
| **C2 — Weekly** | Once a week | Weekly distillation: patterns, execution rate, goal velocity, hypothesis updates | Tactical |
| **C3 — Monthly** | Once a month | Deep drilling: structural shifts, cross-correlations, 10 new hypotheses | Strategic |
| **C4 — Quarterly** | Once a quarter | System audit: metric trajectory, hypothesis clustering, systemic patterns | Architectural |

## C1 — Daily Pipeline

**Input:** raw report (voice → transcription → text).

**AI reads:**
- Today's raw log
- Yesterday's report (directive check)
- metrics.jsonl (last 7 lines — weekly dynamics)
- goals.md (current goals)
- thought_patterns.md (pattern registry)
- calibration_log.md (probability correction)

**AI generates:**
1. ⚡ Signals — what non-obvious things AI noticed
2. Yesterday's directive check (✅/❌ with cause category)
3. Dashboard (Sleep, Energy, GI, DQ, ...)
4. Reality assembly (Internal / External — facts)
5. Deep synthesis (cross-domain, weekly dynamics)
6. Hypotheses (max 2, with novelty gate — AI must not rephrase what the user already said)
7. Tomorrow's directive (ONE ACTION + 3 outcomes)
8. Retrospective (Agile Results format)

**Key C1 rules:**
- Hypotheses must be NEW — cross-domain connection or non-obvious implication. Do not paraphrase the user's words.
- Execution gate: if Exec Rate < 1/3 for 2 consecutive days → skip HYPOTHESES section entirely. Focus on ONE ACTION.
- GI < threshold → preventive mode (recovery).
- System-sticking countermeasure: if «improving the system» replaces actions → signal + ONE ACTION = physical action.

## C2 — Weekly Distillation

**Input:** all 7 daily reports + metrics.jsonl.

**What it does:**
- Aggregates weekly Execution Rate, Goal Velocity
- Updates pattern statuses (active / fading / mastered)
- Updates architect_profile.md and clan_registry.md
- Compares actual hypothesis confirmations with predicted probabilities → calibration_log
- Generates weekly_summary.md

**Threshold:** if Exec Rate = 0/3 for 3+ consecutive days → systemic signal, not just a «bad week».

## C3 — Monthly Deep Dive

**Input:** all weekly_summary.md files for the month + full metrics.jsonl.

**What it does:**
- Trajectory deviation check: actual averages vs long-term trend (±1σ)
- Generates 10 entirely new hypotheses (probability >70%)
- Cross-correlations: how everyday details affect macro decisions
- Searches for structural shifts: what changed not in numbers but in behavioral models
- Updates strategic_hypotheses.md, blind_spots.md, meta_hypotheses.md

## C4 — Quarterly Deep Dive

**Input:** all monthly reports for the quarter + full metrics.jsonl.

**What it does:**
- Full matrix audit: bottlenecks × decision classes × status
- 10 new hypotheses + cross-correlations
- Career strategy reassembly
- Development vectors for the next quarter
- Systemic conclusions (meta_hypotheses)

## System Files

In a real system there are more files (architect_profile, clan_registry, personality_signature). Here — only those in the public repository:

| File | Purpose |
|------|---------|
| `AGENTS.md` | Ideological core: philosophy, thinking protocols, anti-sycophancy |
| `PIPELINE.md` | Processing contours C1-C4 + AI-journal interaction rules |
| `DailyLogTemplate.md` | Daily report template v8.4 |
| `examples/metrics.jsonl` | Structured metrics storage format |
| `core/goals.md` | 3/3/3 goal-setting system (Agile Results) |
| `core/thought_patterns.md` | Behavioral pattern registry |
| `core/all_hypotheses.md` | Hypothesis classification + template |
| `core/calibration_log.md` | AI probability accuracy tracking |
| `core/blind_spots.md` | Critical blind spots |
| `attractors/README.md` | Attractor concept + examples |

## Tech Stack

- **Transcription:** GigaAM (local, CPU) — ffmpeg chunking by 20s
- **AI processing:** DeepSeek V4 (API) — 1M token context, thinking mode
- **Storage:** Markdown files + JSONL metrics + MemPalace KG
- **Orchestration:** shell script + cron

---

## Processing Rules

These rules are part of `AGENTS.md` in a real system. They define AI behavior when processing the journal.

### Hypotheses

**Novelty Gate (mandatory before writing each hypothesis):**
1. Quote the user's specific phrase from the raw log on the hypothesis topic
2. Explicitly state: «What new thing does AI add?» — cross-domain connection, hidden pattern, non-obvious metric implication, or contradiction with the narrative
3. If the answer to point 2 is empty or reduces to rephrasing the user's words → hypothesis REJECTED

AI must not rephrase the user's observations as «its own» hypotheses. If the user has already formulated a thought — AI goes further: finds what they did NOT notice, did NOT connect, or where their conclusion is wrong.

**Fact-checker:** Before generating a hypothesis — verify against available fact sources. A hypothesis is built on facts, not on the absence of facts.

**Confirmation → action:** If a hypothesis is confirmed — AI MUST create a concrete action with a deadline. Without action, confirmation doesn't count.

### Directive

**ONE ACTION:** A concrete starting action with the lowest entry threshold. Format: verb + object + criterion + time. Abstractions forbidden: «take a step», «work on», «check everything». Example: «Send 5 job applications (30 min)».

**3 Daily Outcomes:** Three results by end of day. Not actions («start»), but results («send», «complete», «buy»). Linked to weekly goals.

### Execution

**Execution Rate:** How many of the 3 outcomes were completed. If 0/3 for 3 consecutive days → SIGNAL: «Execution gap». The system doesn't work for analysis — it works for action.

**Exec Gate:** If Exec Rate < 1/3 for 2 consecutive days → HYPOTHESES section is skipped entirely. Focus on ONE ACTION.

**Goal Velocity:** For each weekly goal — days elapsed, days remaining, progress. If < 50% by midweek → SIGNAL.

### System Protection

**System-Sticking:** If the log contains «improved the system», «worked on ExoCortex» instead of actions → SIGNAL. ONE ACTION = physical action, not analysis.

**System Improvement Freeze:** If Exec Rate < 2/3 → ban on system improvements. No new scripts, AGENTS.md edits, refactoring. Exception: bug fixes.

**Moves Count:** External moves (actions with visible results: publication, email, application) vs internal (analysis, refactoring, reading). If internal > external for 3 consecutive days → SIGNAL: «System is closing in on itself».

### Patterns

**Pattern Detector:** 2+ consecutive days ❌ with the same cause category → entry in thought_patterns.md. «Threshold» → MVM (one-minute blocks). «Friction» → remove the specific barrier.

**Procrastination Detector:** If the log contains «browsed the internet», «laid down a bit», «and then watched» with uncompleted outcomes → AI records a substitution activity pattern. Don't judge — state the fact.

### Modes

**GI < threshold → recovery mode.** Directive: recovery, not new tasks. Cardio. Early sleep.

**MODE today:** Recovery / Standard / Push. Determined by metric dynamics over the last 3-7 days. Affects the directive.

**Recovery-Push rhythm:** 1 day recovery → 1-2 days push → result. The system marks the rhythm based on metrics.

---

> This is an architecture description. Real implementation depends on your tools. DeepSeek can be replaced with Claude, GigaAM with Whisper, cron with systemd timers. What matters are the processing contours and the rules for AI-journal interaction.
