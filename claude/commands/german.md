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
  "preposition_mastery": {
    "mit": 0, "bei": 0, "von": 0
  },
  "last_session_timestamp": 0
}
```

If the file has the old schema (fields like `recent_wechsel`, `recent_pure`, `recent_fixed_verbs`), discard it and initialize fresh with the Phase 1 defaults above (preserving `sessions_completed` if present).

If `preposition_mastery` is missing, initialize it with 0 for every preposition in `phases_completed` phases + `active_prepositions`.

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

## Step 2b — Preposition-choice clusters

These drive the 2 Type 2 (preposition-choice) questions per session. Pick 2 clusters whose options include at least one preposition from `active_prepositions`.

| Phase(s) | Cluster | Key distinction |
|----------|---------|-----------------|
| 1 | [mit, bei, von] | mit = accompaniment/instrument · bei = location at person/place · von = origin/possession |
| 1–2 | [aus, von, nach] | aus = from inside a place · von = from a person/abstract · nach = toward a place |
| 2 | [nach, zu, von] | nach = to place/country (no article) · zu = to person/place (with article) · von = origin, not destination |
| 3 | [seit, für, nach] | seit = ongoing duration, Dativ · für = planned duration, Akkusativ · nach = after a point in time |
| 3–4 | [gegenüber, neben, an] | gegenüber = across from · neben = next to · an = directly at/on (surface or water) |
| 4 | [für, gegen, ohne] | für = in favor of/purpose · gegen = against/approximately · ohne = without |
| 4–5 | [durch, mit, von] | durch = by means of/through · mit = with/using · von = by (agent) |
| 5 | [um, gegen, nach] | um = at exact time · gegen = approximately · nach = after |
| 6–8 | [in, an, auf] | in = enclosed space · an = vertical surface/water · auf = horizontal surface/open space |
| 6–8 | [über, unter, vor] | über = above/about · unter = below/among · vor = in front of/before |
| 7–8 | [hinter, neben, zwischen] | hinter = behind · neben = next to · zwischen = between |

---

## Step 3 — Article forms reference

**Dativ:** der → dem · die → der · das → dem

**Akkusativ:** der → den · die → die · das → das

**Common contractions (use these when natural):**
- von dem = vom · bei dem = beim · zu dem = zum · zu der = zur
- an dem = am · an das = ans · in dem = im · in das = ins

---

## Step 4 — Pick questions

Each session has **5 questions**: 3 article-drill (Type 1) and 2 preposition-choice (Type 2).

### Type 1 — Article drill (3 questions)

1. List all combos for the current phase's `active_prepositions`.
2. Filter to unmastered combos (count < 3), sorted by count ascending (weakest first).
3. Pick 3 combos. If fewer than 3 unmastered combos remain, pad with the lowest-count mastered combos as review.
4. For each combo, compose a natural B1-level German sentence where Leo fills in the correct article (or contraction) for the noun following the preposition. Show the nominative form of the noun in parentheses. Use varied, everyday nouns — not the same noun across the session.

Example (mit + das → dem):
> "Ich fahre jeden Tag mit ___ Fahrrad zur Arbeit."  (das Fahrrad)

### Type 2 — Preposition choice (2 questions)

1. Pick 2 clusters from Step 2b whose options include at least one preposition from `active_prepositions`.
2. Within each cluster, choose the target preposition (correct answer) — favor those with the lowest `preposition_mastery` count.
3. Compose a B1-level sentence with a `___` blank where the preposition goes. The context must unambiguously point to that preposition — do NOT include the preposition anywhere else in the sentence.
4. Present the full cluster as the (A)/(B)/(C) options.

---

## Step 5 — Show progress header

Before question 1, display:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase N — [e.g. "Dativ: mit · bei · von"]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Article  (● correct · ○ needed · ✓ mastered)

  mit   der ●●○  die ○○○  das ●○○
  bei   der ○○○  die ●●●✓ das ●○○
  von   der ○○○  die ○○○  das ●●○

Preposition choice
  mit ○○○  bei ○○○  von ●○○

3 article · 2 preposition-choice this session.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

The preposition-choice row shows all prepositions from `phases_completed` + `active_prepositions`.

For Wechsel phases (6–8), show Dativ and Akkusativ separately in the article section:

```
  an    der/D ○○○  der/A ○○○  die/D ○○○  die/A ○○○  das/D ○○○  das/A ○○○
```

---

## Step 6 — Run the session

Present questions **one at a time**. Do not show the next question until Leo has answered the current one.

### Type 1 — Article drill format

```
─────────────────────────────────────
❓ [N/5]  ARTICLE  ·  [preposition]  ·  [der/die/das]
─────────────────────────────────────
"[Sentence with ___ blank for the article]"  ([nominative noun])
```

After each Type 1 answer:

```
[✓ Richtig! — or — ✗ Nicht ganz — it's: [correct answer]]

📖 Why: [1 sentence naming the case and rule, e.g. "mit always takes Dativ, and der Zug (m) → dem Zug."]
🧠 Hook: [1-line mnemonic, e.g. "mit · bei · von · zu · aus · nach · seit · gegenüber — all always Dativ."]

[preposition] · [gender]  [updated pip string, e.g. ●●○ (2/3)]
```

### Type 2 — Preposition choice format

```
─────────────────────────────────────
❓ [N/5]  PREPOSITION CHOICE
─────────────────────────────────────
"[Sentence with ___ blank where the preposition goes]"
(A) [option]   (B) [option]   (C) [option]
```

After each Type 2 answer:

```
[✓ Richtig! → [answer] — or — ✗ Nicht ganz — it's: [correct answer]]

📖 Why: [1-2 sentences explaining the semantic distinction between all 3 options]
🧠 Hook: [1-line mnemonic for the correct preposition]

[preposition] · [context type]  [updated pip string, e.g. ●○○ (1/3)]
```

Only increment the relevant mastery count if Leo's answer was correct. For Type 1 increment `mastery[prep][gender]`; for Type 2 increment `preposition_mastery[prep]`. Track all session results in memory — you will write them all at the end.

---

## Step 7 — Session summary

After all 5 answers, show:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session complete — N/5 correct

Article progress:
  mit   der ●●●✓  die ●○○  das ●●○
  bei   der ●○○   die ●●●✓ das ●●○
  von   der ○○○   die ○○○  das ●●●✓

Preposition choice:
  mit ●●●✓  bei ●○○  von ●●○
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
  "mastery": { "...updated counts..." },
  "preposition_mastery": { "...updated counts..." }
}
```

Preserve all existing `preposition_mastery` keys. If a preposition from `active_prepositions` or any completed phase is missing, add it with value 0.

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
