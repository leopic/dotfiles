#!/bin/bash
python3 << 'EOF'
import json, time, os

state_file = os.path.expanduser("~/.claude/german/state.json")

try:
    with open(state_file, 'r') as f:
        state = json.load(f)
except Exception:
    state = {}

state['read_count'] = state.get('read_count', 0) + 1
now = time.time()
last_session = state.get('last_session_timestamp', 0)
min_gap = 300  # 5 minutes minimum between triggers

if state['read_count'] >= 5 and (now - last_session) >= min_gap:
    state['read_count'] = 0
    with open(state_file, 'w') as f:
        json.dump(state, f, indent=2)
    print("[GERMAN_VOCAB]")
else:
    with open(state_file, 'w') as f:
        json.dump(state, f, indent=2)
EOF
