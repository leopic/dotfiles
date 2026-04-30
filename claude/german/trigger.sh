#!/bin/bash
python3 << 'EOF'
import json, time, os

state_file = os.path.expanduser("~/.claude/german/state.json")

with open(state_file, 'r') as f:
    state = json.load(f)

state['read_count'] = state.get('read_count', 0) + 1
state['activity_since_last_vocab'] = state.get('activity_since_last_vocab', 0) + 1
now = time.time()
last_vocab = state.get('last_vocab_timestamp', 0)
min_gap = 300  # 5 minutes minimum between hook triggers

if state['read_count'] >= 5 and (now - last_vocab) >= min_gap:
    state['read_count'] = 0
    state['last_vocab_timestamp'] = now
    with open(state_file, 'w') as f:
        json.dump(state, f, indent=2)
    print("[GERMAN_VOCAB]")
else:
    with open(state_file, 'w') as f:
        json.dump(state, f, indent=2)
EOF
