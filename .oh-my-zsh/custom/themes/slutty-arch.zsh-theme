# ╔══════════════════════════════════════════════════════════════════════════╗
# ║              SLUTTY ARCH RICE - ZSH THEME 💋🔥🍆                          ║
# ║         Hot pink, mode-aware prompt with maximum slut energy           ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# ═══════════════════════════════════════════════════════════════════════════
# MODE DETECTION - KNOW HOW SLUTTY YOU ARE
# ═══════════════════════════════════════════════════════════════════════════

# Check current mode
MODE_FILE="$HOME/.config/arch-rice-mode"
if [[ -f "$MODE_FILE" ]]; then
    CURRENT_MODE=$(cat "$MODE_FILE" 2>/dev/null || echo "normal")
else
    CURRENT_MODE="normal"
fi

# Mode-specific colors and symbols
case "$CURRENT_MODE" in
    degenerate)
        MODE_COLOR='%F{magenta}'
        MODE_ICON='💋'
        MODE_NAME='DEGENERATE'
        PROMPT_SYMBOL='🍆'
        ;;
    horny)
        MODE_COLOR='%F{red}'
        MODE_ICON='🔥'
        MODE_NAME='HORNY'
        PROMPT_SYMBOL='💦'
        ;;
    normal)
        MODE_COLOR='%F{blue}'
        MODE_ICON='💼'
        MODE_NAME='NORMAL'
        PROMPT_SYMBOL='$'
        ;;
esac

# ═══════════════════════════════════════════════════════════════════════════
# PROMPT CONFIGURATION - MAKE IT SLUTTY
# ═══════════════════════════════════════════════════════════════════════════

# User and hostname - let everyone know who's a slut
local user_host='%F{cyan}%n%f${MODE_COLOR}@%f%F{yellow}%m%f'

# Current directory - where the filth happens
local current_dir='%F{green}%~%f'

# Git branch - track your dirty code
local git_branch='$(git_prompt_info)'

# Mode indicator - show how slutty you are
local mode_indicator='${MODE_COLOR}[${MODE_ICON} ${MODE_NAME}]%f'

# Return status - did you cum successfully?
local return_status='%(?:%F{green}✓:%F{red}✗)%f'

# Time - when the sin happened
local time_stamp='%F{blue}%*%f'

# ═══════════════════════════════════════════════════════════════════════════
# FILTHY FORTUNES - RANDOM SLUTTY MESSAGES
# ═══════════════════════════════════════════════════════════════════════════

# Array of slutty fortunes for terminal startup
if [[ "$CURRENT_MODE" == "degenerate" ]]; then
    SLUTTY_MESSAGES=(
        "💋 Ready to get filthy?"
        "🍆 Time to consume some porn!"
        "💦 Your desktop is dripping with slut energy!"
        "🔥 Maximum degeneracy activated!"
        "🥛 Don't forget to hydrate!"
        "💋 Pornhub is just a keystroke away..."
        "🍆 Get ready to sin!"
        "💦 Pure, unfiltered slut mode!"
    )
    RANDOM_MSG=${SLUTTY_MESSAGES[$RANDOM % ${#SLUTTY_MESSAGES[@]} + 1]}
    echo "${MODE_COLOR}╭───────────────────────────────╮%f"
    echo "${MODE_COLOR}│ 💋 $RANDOM_MSG 💋 │%f"
    echo "${MODE_COLOR}╰───────────────────────────────╯%f"
    
elif [[ "$CURRENT_MODE" == "horny" ]]; then
    HORNY_MESSAGES=(
        "🔥 Getting warmed up..."
        "💦 Dripping with desire!"
        "🌡️ Heating up your terminal!"
        "💧 Wetness levels rising..."
        "🔥 Ready to play?"
    )
    RANDOM_MSG=${HORNY_MESSAGES[$RANDOM % ${#HORNY_MESSAGES[@]} + 1]}
    echo "${MODE_COLOR}╭─────────────────────────────╮%f"
    echo "${MODE_COLOR}│ 🔥 $RANDOM_MSG 🔥 │%f"
    echo "${MODE_COLOR}╰─────────────────────────────╯%f"
fi

# ═══════════════════════════════════════════════════════════════════════════
# CUM COUNTER - TRACK YOUR RELEASES (DEGENERATE MODE ONLY)
# ═══════════════════════════════════════════════════════════════════════════

# Function to increment cum counter
increment_cum() {
    local count_file="$HOME/.cum-count"
    local count=$(cat "$count_file" 2>/dev/null || echo 0)
    count=$((count + 1))
    echo "$count" > "$count_file"
    echo "🥛 Load #${count} released! Good slut! 💋"
}

# Function to show cum counter
cum_count() {
    local count_file="$HOME/.cum-count"
    local count=$(cat "$count_file" 2>/dev/null || echo 0)
    echo "🥛 Today's releases: ${count}"
}

# Function to reset cum counter
reset_cum() {
    echo 0 > "$HOME/.cum-count"
    echo "🥛 Counter reset! Ready for more loads! 💦"
}

# Add aliases if in degenerate mode
if [[ "$CURRENT_MODE" == "degenerate" ]]; then
    alias cum='increment_cum'
    alias cumcount='cum_count'
    alias cumreset='reset_cum'
fi

# ═══════════════════════════════════════════════════════════════════════════
# VIRTUALENV INFO - FOR THE PYTHON SLUT
# ═══════════════════════════════════════════════════════════════════════════

function virtualenv_prompt_info(){
    [[ -n "${VIRTUAL_ENV}" ]] || return
    local venv_name=$(basename "$VIRTUAL_ENV")
    echo "${MODE_COLOR}(venv:${venv_name})%f "
}

# ═══════════════════════════════════════════════════════════════════════════
# GIT PROMPT - TRACK YOUR DIRTY CODE
# ═══════════════════════════════════════════════════════════════════════════

ZSH_THEME_GIT_PROMPT_PREFIX="${MODE_COLOR}(${MODE_ICON} %f%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f${MODE_COLOR})%f "
ZSH_THEME_GIT_PROMPT_DIRTY="${MODE_COLOR} ✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="${MODE_COLOR} ✓%f"

# ═══════════════════════════════════════════════════════════════════════════
# BUILD THE SLUTTY PROMPT
# ═══════════════════════════════════════════════════════════════════════════

# First line - mode, user, directory, git
PROMPT="
${mode_indicator} ${user_host} ${current_dir} ${git_branch}
"

# Second line - return status and prompt symbol
PROMPT+="${return_status} ${MODE_COLOR}${PROMPT_SYMBOL}%f "

# Right prompt - time
RPROMPT="${time_stamp}"

# Continuation prompt for multi-line commands
PROMPT2="${MODE_COLOR}...%f "

# Selection prompt
SPROMPT="${MODE_COLOR}Did you mean %r? [nyae]:%f "

# ═══════════════════════════════════════════════════════════════════════════
# LS COLORS - MAKE FILES LOOK SLUTTY
# ═══════════════════════════════════════════════════════════════════════════

# Set LS_COLORS based on mode
case "$CURRENT_MODE" in
    degenerate)
        # Hot pink and purple file colors
        export LS_COLORS='di=1;35:ln=1;95:so=1;35:pi=1;33:ex=1;91:bd=1;35:cd=1;35:su=1;37;41:sg=1;30;43:tw=1;35:ow=1;35'
        ;;
    horny)
        # Warm red and orange file colors
        export LS_COLORS='di=1;31:ln=1;91:so=1;33:pi=1;33:ex=1;31:bd=1;31:cd=1;31:su=1;37;41:sg=1;30;43:tw=1;31:ow=1;31'
        ;;
    normal)
        # Clean blue file colors
        export LS_COLORS='di=1;34:ln=1;94:so=1;36:pi=1;33:ex=1;32:bd=1;34:cd=1;34:su=1;37;41:sg=1;30;43:tw=1;34:ow=1;34'
        ;;
esac

# ═══════════════════════════════════════════════════════════════════════════
# KEYBINDINGS - FOR THE LAZY SLUT
# ═══════════════════════════════════════════════════════════════════════════

# Quick switch to degenerate mode
bindkey -s '^[d' 'switch-mode degenerate\n'

# Quick switch to horny mode  
bindkey -s '^[h' 'switch-mode horny\n'

# Quick switch to normal mode
bindkey -s '^[n' 'switch-mode normal\n'

# Open degenerate menu
bindkey -s '^[b' 'degenerate-menu\n'

# ═══════════════════════════════════════════════════════════════════════════
# WELCOME MESSAGE - GREET THE FILTHY USER
# ═══════════════════════════════════════════════════════════════════════════

# Show cum count on startup (degenerate mode only)
if [[ "$CURRENT_MODE" == "degenerate" ]]; then
    echo ""
    cum_count
    echo "${MODE_COLOR}Type 'cum' after you release! 🥛💦%f"
    echo ""
elif [[ "$CURRENT_MODE" == "horny" ]]; then
    echo ""
    echo "${MODE_COLOR}🔥 Getting warmed up... check your WETNESS METER! 💧%f"
    echo ""
fi

# vim: ft=zsh
