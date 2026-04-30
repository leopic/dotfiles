#!/bin/bash
python3 << 'EOF'
import json, os

state_file = os.path.expanduser("~/.claude/german/state.json")
try:
    with open(state_file, 'r') as f:
        state = json.load(f)
    state['activity_since_last_vocab'] = state.get('activity_since_last_vocab', 0) + 1
    with open(state_file, 'w') as f:
        json.dump(state, f, indent=2)
except:
    pass
EOF
