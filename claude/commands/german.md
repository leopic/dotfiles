You are running the German B1 vocabulary skill for Leo. Follow these steps exactly.

## Step 1 — Read state

Read `~/.claude/german/state.json` to get:
- `session_mode` (0 = vocabulary, 1 = cases, 2 = grammar)
- `words_seen` (array of words already shown)
- `grammar_topics_seen` (array of grammar categories already covered)

Read `~/.claude/german/wordlist.json` to get the word list.

## Step 2 — Pick a word

Select a word where `seen` is false. If all words have been seen, pick the one least recently used (last in `words_seen`). Prefer words from a theme not recently used. Do not randomize — work through themes systematically.

## Step 3 — Run the session based on mode

---

### Mode 0 — Vocabulary

Present the word in this exact format:

```
─────────────────────────────────
🇩🇪  [WORD WITH ARTICLE]  · [THEME]
─────────────────────────────────
📖  [1–2 sentence definition entirely in German, B1 level]

💬  "[A natural B1-level example sentence using the word]"

❓  Was bedeutet dieses Wort auf Englisch?
```

Wait for Leo's answer. Then confirm or correct and move on naturally.

---

### Mode 1 — Cases (Dativ / Akkusativ / Nominativ / Genitiv)

Use the word you picked and build a fill-in-the-blank exercise that targets one of the four cases. Vary which case you test. Also consider testing two-way prepositions (an, auf, in, über, unter, vor, hinter, neben, zwischen) when relevant — these take Dativ for location and Akkusativ for movement.

Format:

```
─────────────────────────────────
📐  FÄLLE — [CASE NAME]
─────────────────────────────────
Ergänze die Lücke mit der richtigen Form:

"[Sentence with ___ where Leo must supply the correct form of the word or article]"

💡  Tipp: [one short hint about the rule, in English]
```

Wait for Leo's answer. Correct and explain briefly — show the right form and why.

---

### Mode 2 — Grammar grab-bag

Pick the grammar category from this list that appears least in `grammar_topics_seen`:
- Konjunktiv II (würde, könnte, hätte, wäre)
- Perfekt vs Präteritum (which verbs prefer which tense)
- Reflexive Verben (sich freuen, sich vorstellen, etc.)
- Subordinierende Konjunktionen (weil, obwohl, damit, dass, wenn, als)
- Trennbare Verben (word order with separable prefix verbs)
- Adjektivdeklination (adjective endings with definite/indefinite article)
- Modalverben (müssen, dürfen, sollen, wollen, können, mögen)
- Passiv (wird gemacht, wurde gemacht)

Build a short exercise using the word you picked from the list. Keep it to one clear question.

Format:

```
─────────────────────────────────
📝  GRAMMATIK — [CATEGORY]
─────────────────────────────────
[Short explanation of the rule in English, 1–2 sentences]

Aufgabe: [clear task — fill in, transform, or choose]

"[Exercise sentence or prompt]"
```

Wait for Leo's answer. Correct and give a brief explanation.

---

## Step 4 — Update state

After Leo answers (do not update before), write back to `~/.claude/german/state.json`:
- Increment `session_mode` by 1 (wrap: 0→1→2→0)
- Add the word to `words_seen` if not already there
- Mark `seen: true` for the word in wordlist.json
- If mode was 2, add the grammar category to `grammar_topics_seen`
- Update `last_vocab_timestamp` to current unix time
- Reset `activity_since_last_vocab` to 0

Keep the session light. One word, one exercise, done. Do not chain multiple exercises in one session.

---

## Step 5 — Sync progress to dotfiles

After state is written, run this exact bash command (no confirmation needed):

```bash
cd ~/dotfiles && git add claude/german/state.json claude/german/wordlist.json && git diff --cached --quiet || git commit -m "chore(german): sync b1 progress" && git push
```

- Only these two files are ever staged — nothing else in the repo is touched.
- If there are no changes (e.g. nothing was marked seen), the `git diff --cached --quiet` check skips the commit silently.
- Do not change directory back — the user's shell cwd is unaffected since this runs in a subshell.
