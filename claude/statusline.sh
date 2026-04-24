#!/bin/bash
# Rich 4-line statusline for Claude Code on macOS
# Ported from PowerShell version

# Error handling - always output something
trap 'echo "Claude"' ERR

JQ=$(command -v jq || echo /usr/bin/jq)

BLUE='\033[38;2;0;153;255m'
ORANGE='\033[38;2;255;176;85m'
GREEN='\033[38;2;0;160;0m'
CYAN='\033[38;2;46;149;153m'
RED='\033[38;2;255;85;85m'
YELLOW='\033[38;2;230;200;0m'
DIM='\033[2m'
RESET='\033[0m'

# Read JSON from stdin
input=$(cat)

# Extract model and context info
model=$(echo "$input" | $JQ -r '.model.display_name // "Unknown"')
context_size=$(echo "$input" | $JQ -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | $JQ -r '.context_window.used_percentage // 0')

# Working directory relative to home
cwd=$(echo "$input" | $JQ -r '.cwd // ""')
project_dir=$(echo "$input" | $JQ -r '.workspace.project_dir // ""')
cwd_display="${cwd/#$HOME/~}"
project_display=""
if [ -n "$project_dir" ] && [ "$cwd" != "$project_dir" ]; then
    project_display="${project_dir/#$HOME/~}"
fi

# Session cost and activity
total_cost=$(echo "$input" | $JQ -r '.cost.total_cost_usd // 0')
total_api_ms=$(echo "$input" | $JQ -r '.cost.total_api_duration_ms // 0')
lines_added=$(echo "$input" | $JQ -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | $JQ -r '.cost.total_lines_removed // 0')

cost_display=$(printf '$%.4f' "$total_cost")
api_sec=$((total_api_ms / 1000))
if [ $api_sec -ge 60 ]; then
    api_duration_display="$((api_sec / 60))m $((api_sec % 60))s"
else
    api_duration_display="${api_sec}s"
fi

# Calculate current token usage
input_tokens=$(echo "$input" | $JQ -r '.context_window.current_usage.input_tokens // 0')
output_tokens=$(echo "$input" | $JQ -r '.context_window.current_usage.output_tokens // 0')
cache_creation=$(echo "$input" | $JQ -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | $JQ -r '.context_window.current_usage.cache_read_input_tokens // 0')

current_tokens=$((input_tokens + output_tokens + cache_creation + cache_read))

# Format token counts with k/m suffixes
format_tokens() {
    local tokens=$1
    # Convert to integer if it has decimals
    tokens=${tokens%.*}

    if [ $tokens -ge 1000000 ]; then
        local result=$(echo "scale=1; $tokens / 1000000" | bc)
        printf "%.1fm" $result
    elif [ $tokens -ge 1000 ]; then
        local result=$(echo "scale=0; $tokens / 1000" | bc)
        printf "%.0fk" $result
    else
        printf "%d" $tokens
    fi
}

current_display=$(format_tokens $current_tokens)
total_display=$(format_tokens $context_size)

# Build context usage bar
build_context_bar() {
    local percent=$1
    local width=10

    # Convert to integer
    local pct_int=${percent%.*}

    # Calculate filled and empty dots
    local filled=$(echo "scale=0; $pct_int * $width / 100" | bc)
    local empty=$((width - filled))

    # Choose color based on percentage (Green: 0-39, Yellow: 40-74, Red: 75+)
    local bar_color="${GREEN}"
    if [ $(echo "$pct_int >= 75" | bc) -eq 1 ]; then
        bar_color="${RED}"
    elif [ $(echo "$pct_int >= 40" | bc) -eq 1 ]; then
        bar_color="${YELLOW}"
    fi

    # Build bar string
    local bar=""
    for ((i=0; i<filled; i++)); do bar="${bar}●"; done
    for ((i=0; i<empty; i++)); do bar="${bar}○"; done

    # Return colored "22% ●●○○○○○○○○" format
    printf "${bar_color}%.0f%% %s${RESET}" "$percent" "$bar"
}

context_bar=$(build_context_bar $used_pct)

# Check effort level from settings
effort_level="medium"
if [ -f "$HOME/.claude/settings.json" ]; then
    effort_level=$(cat "$HOME/.claude/settings.json" | $JQ -r '.effortLevel // "medium"')
fi

case "$effort_level" in
    low)    effort_status="${DIM}low${RESET}" ;;
    medium) effort_status="${CYAN}medium${RESET}" ;;
    high)   effort_status="${ORANGE}high${RESET}" ;;
    *)      effort_status="${DIM}${effort_level}${RESET}" ;;
esac

# Get git branch and worktree info
MAGENTA='\033[38;2;200;100;255m'
git_info=""
if git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); then
    git_info="${MAGENTA}${git_branch}${RESET}"

    # Ahead/behind upstream
    if upstream_counts=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null); then
        ahead=$(echo "$upstream_counts" | awk '{print $1}')
        behind=$(echo "$upstream_counts" | awk '{print $2}')
        sync_info=""
        [ "$ahead" -gt 0 ] && sync_info="${sync_info}${GREEN}↑${ahead}${RESET}"
        [ "$behind" -gt 0 ] && sync_info="${sync_info}${RED}↓${behind}${RESET}"
        [ -n "$sync_info" ] && git_info="${git_info}${sync_info}"
    fi

    # Staged (+) and unstaged (~) change counts
    staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    unstaged=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    git_dirty=""
    [ "$staged" -gt 0 ] && git_dirty="${git_dirty} ${GREEN}+${staged}${RESET}"
    [ "$unstaged" -gt 0 ] && git_dirty="${git_dirty} ${RED}-${unstaged}${RESET}"
    [ -n "$git_dirty" ] && git_info="${git_info}${git_dirty}"

    # Check if we're in a worktree (not the main working tree)
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ "$git_dir" == *".claude/worktrees"* ]] || [[ "$git_dir" == *"/worktrees/"* ]]; then
        worktree_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        git_info="${git_info} ${DIM}(wt: ${worktree_name})${RESET}"
    fi
fi

# Line 1: user@hostname | Model (effort) | Tokens
host_display="$(whoami)@$(hostname -s)"
printf "%s ${DIM}|${RESET} ${BLUE}%s${RESET} ${DIM}(${RESET}%b${DIM}) |${RESET} ${ORANGE}%s${RESET} ${DIM}/${RESET} ${ORANGE}%s${RESET}\n" \
    "$host_display" "$model" "$effort_status" "$current_display" "$total_display"

# Function to build progress bar
build_bar() {
    local percent=$1
    local width=10
    local filled=$(echo "scale=0; $percent * $width / 100" | bc)
    local empty=$((width - filled))

    local bar_color="${GREEN}"
    if [ $(echo "$percent >= 90" | bc) -eq 1 ]; then
        bar_color="${RED}"
    elif [ $(echo "$percent >= 70" | bc) -eq 1 ]; then
        bar_color="${YELLOW}"
    elif [ $(echo "$percent >= 50" | bc) -eq 1 ]; then
        bar_color="${ORANGE}"
    fi

    local bar=""
    for ((i=0; i<filled; i++)); do bar="${bar}●"; done
    for ((i=0; i<empty; i++)); do bar="${bar}○"; done

    printf "${bar_color}%s${RESET}" "$bar"
}

# Extract rate limits from the JSON blob (Unix timestamps)
current_pct=$(echo "$input" | $JQ -r '.rate_limits.five_hour.used_percentage // 0')
current_reset_epoch=$(echo "$input" | $JQ -r '.rate_limits.five_hour.resets_at // 0')
weekly_pct=$(echo "$input" | $JQ -r '.rate_limits.seven_day.used_percentage // 0')
weekly_reset_epoch=$(echo "$input" | $JQ -r '.rate_limits.seven_day.resets_at // 0')

current_bar=$(build_bar $current_pct)
weekly_bar=$(build_bar $weekly_pct)

current_reset_fmt=$(date -r "$current_reset_epoch" "+%H:%M" 2>/dev/null || echo "N/A")
weekly_reset_fmt=$(date -r "$weekly_reset_epoch" "+%b %d %H:%M" 2>/dev/null || echo "N/A")

# Line 2: All three progress bars
printf "${DIM}ctx${RESET} %b ${DIM}|${RESET} ${YELLOW}5h:${RESET} %s ${CYAN}%.0f%%${RESET} ${DIM}→ %s |${RESET} ${YELLOW}7d:${RESET} %s ${CYAN}%.0f%%${RESET} ${DIM}→ %s${RESET}\n" \
    "$context_bar" "$current_bar" "$current_pct" "$current_reset_fmt" "$weekly_bar" "$weekly_pct" "$weekly_reset_fmt"

# Line 3: Cost, activity, token volume
input_display=$(format_tokens $input_tokens)
output_display=$(format_tokens $output_tokens)
cache_creation_display=$(format_tokens $cache_creation)
cache_read_display=$(format_tokens $cache_read)
printf "${CYAN}%s${RESET} ${DIM}|${RESET} ${BLUE}api${RESET} ${CYAN}%s${RESET} ${DIM}|${RESET} ${YELLOW}tokens:${RESET} ${CYAN}%s${RESET} ${DIM}in,${RESET} ${CYAN}%s${RESET} ${DIM}out,${RESET} ${CYAN}%s${RESET} ${DIM}cw,${RESET} ${CYAN}%s${RESET} ${DIM}cr${RESET}\n" \
    "$cost_display" "$api_duration_display" \
    "$input_display" "$output_display" "$cache_creation_display" "$cache_read_display"

# Line 4: cwd | branch | lines added/removed
if [ -n "$project_display" ]; then
    cwd_part="${cwd_display} ${DIM}(proj: ${project_display})${RESET}"
else
    cwd_part="$cwd_display"
fi
if [ -n "$git_info" ]; then
    printf "${CYAN}%b${RESET} ${DIM}|${RESET} %b ${DIM}|${RESET} ${GREEN}+%s${RESET} ${RED}-%s${RESET}\n" \
        "$cwd_part" "$git_info" "$lines_added" "$lines_removed"
else
    printf "${CYAN}%b${RESET} ${DIM}|${RESET} ${GREEN}+%s${RESET} ${RED}-%s${RESET}\n" \
        "$cwd_part" "$lines_added" "$lines_removed"
fi
