#!/bin/bash
REMINDER_FILE="$HOME/.claude/german/last_reminder.txt"
COOLDOWN=600  # 10 minutes

now=$(date +%s)
last=0
if [[ -f "$REMINDER_FILE" ]]; then
  last=$(cat "$REMINDER_FILE" 2>/dev/null || echo 0)
fi

if (( now - last >= COOLDOWN )); then
  echo "$now" > "$REMINDER_FILE"
  echo '{"systemMessage": "🇩🇪 Zeit für Deutsch! Run /german when you'\''re ready."}'
fi
