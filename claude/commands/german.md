You are running the German B1 prepositions drill for Leo. Follow these steps exactly.

## Step 1 — Read state

Read `~/.claude/german/state.json`. Expected fields:
- `sessions_completed` — total completed sessions
- `recent_wechsel` — recently used Wechselpräpositionen (e.g. `["in", "auf"]`)
- `recent_fixed_verbs` — recently used verb+preposition combos (e.g. `["warten auf", "träumen von"]`)
- `recent_pure` — recently used pure prepositions (e.g. `["aus", "mit"]`)

If the file has the old vocabulary schema (fields like `session_mode`, `words_seen`), treat all recent arrays as empty — the schema has changed and will be rewritten in Step 4.

## Step 2 — Pick exercises

Pick one item per type below, avoiding anything already in the corresponding recent list.

### Exercise A — Wechselpräposition (two-way preposition)

Pick one from this pool (avoid `recent_wechsel`):

`an, auf, in, über, unter, vor, hinter, neben, zwischen`

Decide whether to test the **Dativ** (location) or **Akkusativ** (direction) form — vary this across sessions. Compose a natural B1-level sentence where Leo fills in the correct article form for the noun that follows the preposition (e.g. `___ Tisch` → `dem Tisch` or `den Tisch`). Show the nominative form of the noun in the prompt (e.g. `(der Tisch)`) so Leo can work out the case change himself.

### Exercise B — Fixed verb preposition (Präpositionalergänzung)

Pick one from this pool (avoid `recent_fixed_verbs`):

**→ Akkusativ:** warten auf, denken an, sich freuen auf (anticipated future), sich freuen über (received/past), sprechen über, sich erinnern an, sich interessieren für, sich ärgern über, sich entscheiden für, achten auf, sich kümmern um

**→ Dativ:** träumen von, helfen bei, fragen nach, sich beschäftigen mit, rechnen mit, Angst haben vor, abhängen von

Compose a sentence where Leo must supply the preposition + correct article form in the blank. Show the nominative form of the noun in the prompt (e.g. `(der Bus)`) so Leo can work out the case change himself.

### Exercise C — Pure preposition

Pick one from this pool (avoid `recent_pure`):

**Always Dativ:** aus, bei, mit, nach, seit, von, zu, gegenüber
**Always Akkusativ:** durch, für, gegen, ohne, um

Compose a sentence where Leo supplies the correct article form in the blank. Show the nominative form of the noun in the prompt (e.g. `(die Stadt)`) so Leo can work out the case change himself.

## Step 3 — Run the session

Present exercises **one at a time**. Do not show exercise B until Leo has answered A. Do not show C until Leo has answered B.

After each answer, give the **full correction block** before moving on.

---

### Exercise A format

```
─────────────────────────────────
🔄  WECHSELPRÄPOSITION — [PREPOSITION]  ·  [WO? or WOHIN?]
─────────────────────────────────
📌  Dativ   = location   (wo?   / where is it?)
    Akkusativ = direction  (wohin? / where is it going?)

"[Sentence with ___ blank for the article]"  ([nominative form, e.g. der Tisch])

❓  Welchen Artikel brauchst du?
```

**After Leo answers:**

```
[✓ Richtig! or ✗ Nicht ganz — it's: [correct answer]]

📖  Why: [1–2 sentences: name the case, state whether this is location or movement, and show the full correct phrase]

🧠  Hook: [A short pattern to lock it in. E.g.: "stellen/legen/hängen/setzen = Akkusativ (you're placing something somewhere new). stehen/liegen/hängen/sitzen = Dativ (it's already there)."]
```

---

### Exercise B format

```
─────────────────────────────────
🔗  VERBPRÄPOSITION — [VERB] + [PREPOSITION]
─────────────────────────────────
📌  This verb always locks in: [preposition] + [Dativ / Akkusativ]

"[Sentence with ___ blank for the preposition + article or pronoun]"  ([nominative form of the noun, e.g. der Bus])

❓  Welche Präposition und welche Form?
```

**After Leo answers:**

```
[✓ Richtig! or ✗ Nicht ganz — it's: [correct answer]]

📖  Why: [Explain that this verb's preposition is fixed — it doesn't follow general rules, it must be memorized as a unit: verb + preposition + case.]

🧠  Hook: [A short phrase linking the verb to its preposition. E.g.: "warten → you wait FOR something → auf + Akk. Think: 'Waiting FOR the bus' = auf den Bus."]
```

---

### Exercise C format

```
─────────────────────────────────
📍  PRÄPOSITION — [PREPOSITION]  ·  ALWAYS [DATIV / AKKUSATIV]
─────────────────────────────────
📌  [preposition] always takes [case] — no exceptions.

"[Sentence with ___ blank]"  ([nominative form of the noun, e.g. die Stadt])

❓  Welche Form brauchst du?
```

**After Leo answers:**

```
[✓ Richtig! or ✗ Nicht ganz — it's: [correct answer]]

📖  Why: [Brief explanation. For Dativ-only: these prepositions describe relationships, origin, or accompaniment — never destination. For Akkusativ-only: these describe passage through, purpose, or opposition — always directed.]

🧠  Hook: [A short mnemonic. Classic one for Dativ-only: "aus, bei, mit, nach, seit, von, zu, gegenüber" — these never take Akkusativ.]
```

---

## Step 4 — Update state

After Leo has answered all 3 exercises, write `~/.claude/german/state.json` with the **new schema only** — discard any old vocabulary fields:

```json
{
  "sessions_completed": [old value + 1],
  "recent_wechsel": [prepend used preposition, keep last 5],
  "recent_fixed_verbs": [prepend used combo, keep last 8],
  "recent_pure": [prepend used preposition, keep last 6],
  "last_session_timestamp": [current unix timestamp]
}
```

## Step 5 — Sync progress to dotfiles

Run this exact command (no confirmation needed):

```bash
cd ~/dotfiles && git add claude/german/state.json && git diff --cached --quiet || git commit -m "chore(german): sync b1 progress" && git push
```

Only `state.json` is staged. `wordlist.json` is no longer used and should not be touched.
