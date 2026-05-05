You are running the German B1 prepositions drill for Leo. Follow these steps exactly.

## Step 1 — Read state

Read `~/.claude/german/state.json`. Expected schema:

```json
{
  "sessions_completed": 3,
  "phase": 1,
  "phases_completed": [],
  "active_prepositions": ["mit", "bei", "von"],
  "mastery": {
    "mit": { "der": 0, "die": 0, "das": 0 },
    "bei": { "der": 0, "die": 0, "das": 0 },
    "von": { "der": 0, "die": 0, "das": 0 }
  },
  "last_session_timestamp": 0
}
```

If the file has the old schema (fields like `recent_wechsel`, `recent_pure`, `recent_fixed_verbs`), discard it and initialize fresh with the Phase 1 defaults above (preserving `sessions_completed` if present).

---

## Step 2 — Phase map

| Phase | Prepositions | Case rule |
|-------|--------------|-----------|
| 1 | mit, bei, von | always Dativ |
| 2 | aus, nach, zu | always Dativ |
| 3 | seit, gegenüber | always Dativ |
| 4 | durch, für, gegen | always Akkusativ |
| 5 | ohne, um | always Akkusativ |
| 6 | an, auf, in | Wechsel — both Dativ and Akkusativ |
| 7 | über, unter, vor | Wechsel |
| 8 | hinter, neben, zwischen | Wechsel |

**Mastery threshold:** 3 correct answers per combo. Incorrect answers do not decrement.

**Combos per phase:**
- Phases 1–5: `preposition × gender` → 3 combos per preposition (der, die, das)
- Phases 6–8: `preposition × gender × case` → 6 combos per preposition (der/Dat, der/Akk, die/Dat, die/Akk, das/Dat, das/Akk)

---

## Step 3 — Article forms reference

**Dativ:** der → dem · die → der · das → dem

**Akkusativ:** der → den · die → die · das → das

**Common contractions (use these when natural):**
- von dem = vom · bei dem = beim · zu dem = zum · zu der = zur
- an dem = am · an das = ans · in dem = im · in das = ins

---

## Step 4 — Pick questions

1. List all combos for the current phase's `active_prepositions`.
2. Filter to unmastered combos (count < 3), sorted by count ascending (weakest first).
3. Pick **5 combos** from that list. If fewer than 5 unmastered combos remain, pad with the lowest-count mastered combos as review.
4. For each combo, compose a natural B1-level German sentence where Leo fills in the correct article (or contraction) for the noun following the preposition. Show the nominative form of the noun in parentheses. Use varied, everyday nouns — not the same noun across the session.

Example (mit + das → dem):
> "Ich fahre jeden Tag mit ___ Fahrrad zur Arbeit."  (das Fahrrad)

---

## Step 5 — Show progress header

Before question 1, display:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase N — [e.g. "Dativ: mit · bei · von"]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Progress  (● correct · ○ needed · ✓ mastered)

  mit   der ●●○  die ○○○  das ●○○
  bei   der ○○○  die ●●●✓ das ●○○
  von   der ○○○  die ○○○  das ●●○

5 questions this session.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

For Wechsel phases (6–8), show Dativ and Akkusativ separately:

```
  an    der/D ○○○  der/A ○○○  die/D ○○○  die/A ○○○  das/D ○○○  das/A ○○○
```

---

## Step 6 — Run the session

Present questions **one at a time**. Do not show the next question until Leo has answered the current one.

### Question format

```
─────────────────────────────────────
❓ [N/5]  [PREPOSITION]  ·  noun gender: [der/die/das]
─────────────────────────────────────
"[Sentence with ___ blank]"  ([nominative noun])
```

### After each answer

```
[✓ Richtig! — or — ✗ Nicht ganz — it's: [correct answer]]

📖 Why: [1 sentence naming the case and rule, e.g. "mit always takes Dativ, and der Zug (m) → dem Zug."]
🧠 Hook: [1-line mnemonic, e.g. "mit · bei · von · zu · aus · nach · seit · gegenüber — all always Dativ."]

[preposition] · [gender]  [updated pip string, e.g. ●●○ (2/3)]
```

Only increment the mastery count if Leo's answer was correct. Track the session's results in memory — you will write them all at the end.

---

## Step 7 — Session summary

After all 5 answers, show:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session complete — N/5 correct

Updated progress:
  mit   der ●●●✓  die ●○○  das ●●○
  bei   der ●○○   die ●●●✓ das ●●○
  von   der ○○○   die ○○○  das ●●●✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Phase completion check:** if every combo for every active preposition now has count ≥ 3, show:

```
🎉 Phase N mastered! You've nailed: [preposition list]
Next up → Phase N+1: [new prepositions]  ([case rule])
```

Then advance: increment `phase`, set `active_prepositions` to the next phase's prepositions, reset `mastery` to all zeros for the new prepositions, and append the completed phase number to `phases_completed`.

If there is no Phase 9, show a completion message instead: "🏆 All phases complete — you've mastered the German preposition system!"

---

## Step 8 — Update state

Write `~/.claude/german/state.json` with the updated values:

```json
{
  "sessions_completed": [old + 1],
  "phase": [current or advanced],
  "phases_completed": [...],
  "active_prepositions": [...],
  "mastery": { "...updated counts..." }
}
```

`last_session_timestamp` is stamped by the bash command in Step 9 — do not set it here.

---

## Step 9 — Stamp timestamp and sync

Run these exact commands (no confirmation needed):

```bash
jq --argjson ts $(date +%s) '.last_session_timestamp = $ts' ~/.claude/german/state.json > /tmp/german_state_tmp.json && mv /tmp/german_state_tmp.json ~/.claude/german/state.json
```

```bash
cd ~/dotfiles && git add claude/german/state.json && git diff --cached --quiet || git commit -m "chore(german): sync b1 progress" && git push
```
