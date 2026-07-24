You are running Leo's Goethe-Zertifikat B1 Schreiben (writing) practice. Follow these steps exactly.

This is a ~8-10 minute daily rep, separate from the `/german` grammar drill. Keep everything tight — this is not a full correction service.

---

## Step -1 — Pull latest state

Before doing anything else, run:

```bash
cd ~/dotfiles && git pull --ff-only
```

This repo syncs state across multiple devices/sessions — always pull first so you're never grading or advancing against a stale local copy. If this fails (diverged history, or uncommitted local changes blocking the pull), stop and tell Leo what's blocking it rather than trying to force-resolve it yourself.

---

## Step 0 — Read state

Read `~/.claude/german/state.json`. Look for the `writing` key with this schema:

```json
{
  "sessions_completed": 0,
  "next_task_type": "teil1",
  "recent_topics": [],
  "error_tags": {
    "wortstellung_v2": 0,
    "wortstellung_nebensatz": 0,
    "kasus": 0,
    "konnektoren": 0,
    "register": 0,
    "wortschatz": 0,
    "rechtschreibung": 0,
    "zeichensetzung": 0,
    "struktur": 0
  },
  "history": []
}
```

If the `writing` key is missing, initialize it with these defaults. If `error_tags` is missing any of the 9 keys listed above, add them at 0.

---

## Step 1 — Task type map

`next_task_type` cycles `teil1` → `teil2` → `teil3` → `teil1` ...

| Task | Real exam | Word target | Suggested write time | Scoring (Aufgabenerfüllung / Kohärenz / Wortschatz / Grammatik) |
|------|-----------|-------------|----------------------|------------------------------------------------------------------|
| `teil1` | Semi-formal email to a friend/acquaintance | ~80 words | ~8 min | 10 / 10 / 10 / 10 (max 40) |
| `teil2` | Opinion piece / forum reply to a discussion statement | ~80 words | ~9 min | 10 / 10 / 10 / 10 (max 40) |
| `teil3` | Short formal email (decline, reschedule, apologize) | ~40 words | ~5 min | 4 / 4 / 6 / 6 (max 20) |

All tasks require a real letter/email structure: appropriate Anrede (salutation), a body that addresses every point given in the prompt, and an appropriate Grußformel (closing) matching the register (informal `du` for teil1/teil2 friend-scenarios, formal `Sie` for teil2 forum-to-strangers and all of teil3).

---

## Step 2 — Generate the prompt

Compose a fresh, natural B1-level scenario for the current `next_task_type`. Give Leo 3-4 concrete content points he must address (mirrors the real exam's bullet-point prompts) — do not leave it open-ended.

Draw from varied angles per type, and do NOT reuse any topic in `recent_topics` (last 6 sessions):

- **teil1** (email to a friend): recapping an event, explaining a plan or invitation, asking for advice, describing a recent experience and asking their opinion, apologizing for something minor and proposing to meet up.
- **teil2** (opinion/forum reply): social media vs. personal contact, home office vs. office work, environmental habits/plastic use, city vs. country living, smartphones and children, learning languages online vs. in person, work-life balance.
- **teil3** (short formal note): declining an invitation/meeting due to a conflict, informing an instructor/service provider of a schedule change, requesting to reschedule an appointment, notifying about lateness or absence with an apology.

Register per type: teil1 = informal (`du`). teil2 = check the scenario — a forum reply to a public discussion is usually formal/neutral (`Sie` or impersonal), a reply framed as being among friends is informal. teil3 = always formal (`Sie`).

---

## Step 3 — Show progress header

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Schreiben — Session N
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Last 3 sessions:  [teil2: 32/40 · teil3: 16/20 · teil1: 29/40]
Top recurring issues:  [kasus (7) · konnektoren (5) · register (3)]

Today: [Teil label]  ·  ~[N] words  ·  ~[N] min
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

If `history` has fewer than 3 entries, show what's available and omit the rest. If `history` is empty, omit both trend lines and just show "First session — let's establish a baseline."

---

## Step 4 — Present the prompt and wait

```
─────────────────────────────────────
✍️  [Teil label]  ·  ~[word target] Wörter  ·  ~[time] Min
─────────────────────────────────────
[Scenario in German, 2-3 sentences setting the situation]

Schreib über folgende Punkte:
– [point 1]
– [point 2]
– [point 3]
[– point 4 if natural]
```

Wait for Leo's written response. Do not grade until he replies.

---

## Step 5 — Grade

Score each of the 4 categories as a fraction of its max for this task type, using these anchors:

- **100%** — fully achieved, no meaningful weakness
- **~70%** — mostly achieved, minor slips that don't obscure meaning
- **~50%** — partially achieved, noticeable gaps a reader would trip on
- **~30%** — major gaps, weak control of this dimension
- **0%** — not achieved / off-task / missing entirely

Categories:
- **Aufgabenerfüllung** — did he address all the given content points, at appropriate length, in the right register?
- **Kohärenz** — logical order, paragraph/sentence linking, appropriate connectors (deshalb, trotzdem, obwohl, außerdem, etc.), text reads as one piece not disconnected sentences.
- **Wortschatz** — range and precision of vocabulary; flag if it's noticeably A2-level/repetitive rather than B1.
- **Grammatik/Struktur** — verb position (V2 in main clauses, verb-final in subordinate clauses), case endings, verb conjugation, word order, spelling, punctuation.

Round to whole points. Show the total and max (e.g. "27/40").

---

## Step 6 — Feedback

Keep this tight — 2-3 fixes max, not a full line edit. Format:

```
[Total]/[Max]  —  Aufgabenerfüllung [x]/[max] · Kohärenz [x]/[max] · Wortschatz [x]/[max] · Grammatik [x]/[max]

✓ What worked: [1-2 concrete things, quoting his phrasing]

Fixes:
1. "[exact phrase from his text]" → "[corrected version]"
   [1 sentence why — name the rule]
2. "[exact phrase]" → "[corrected version]"
   [1 sentence why]
[3. optional third fix]

Model touch-up: "[1-2 of his sentences upgraded to more natural/precise B1 phrasing]"
```

Tag every fix with one or more of the 9 `error_tags` keys (wortstellung_v2, wortstellung_nebensatz, kasus, konnektoren, register, wortschatz, rechtschreibung, zeichensetzung, struktur). Increment each tagged key by 1 in state — these are cumulative counts across all sessions, not per-session resets.

---

## Step 7 — Trend recap (every 5th session)

If `sessions_completed + 1` is divisible by 5, add before the closing rule:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
5-session check-in
Score trend: [brief read on direction — improving / flat / dipped, per task type if visible]
Top recurring issues: [top 3 error_tags by count]
Focus for next week: [one specific, actionable recommendation tied to the #1 issue]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Step 8 — Update state

Update the `writing` key in `~/.claude/german/state.json`:

- `sessions_completed`: +1
- `next_task_type`: advance the rotation (teil1→teil2, teil2→teil3, teil3→teil1)
- `recent_topics`: append this session's topic; keep only the last 6
- `error_tags`: incremented counts from Step 6
- `history`: append `{ "session": N, "task_type": "...", "topic": "...", "word_count": N, "scores": {"aufgabenerfuellung": x, "kohaerenz": x, "wortschatz": x, "grammatik": x}, "total": x, "max": x, "error_tags": [...] }`. Keep only the last 30 entries (drop oldest beyond that).

Preserve every other top-level key in `state.json` untouched (grammar drill data, `next_mode`, etc.) — this command only touches the `writing` key.

---

## Step 9 — Sync

Run this exact command (no confirmation needed):

```bash
bash ~/.claude/german/sync.sh
```
