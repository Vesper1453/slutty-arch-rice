#!/usr/bin/env bash

# ═══════════════════════════════════════════════════════════════════════
# THEME LOADER - Loads current theme configuration
# ═══════════════════════════════════════════════════════════════════════

THEME_DIR="$HOME/.config/rice"
THEME_CONFIG="$THEME_DIR/current-theme.conf"

# Default to degenerate if no theme set
if [ ! -f "$THEME_CONFIG" ]; then
    mkdir -p "$THEME_DIR"
    cp "$HOME/.config/themes/degenerate/theme.conf" "$THEME_CONFIG"
fi

# Source the theme
source "$THEME_CONFIG"

# ═══════════════════════════════════════════════════════════════════════
# APPLY I3 COLORS
# ═══════════════════════════════════════════════════════════════════════

I3_CONFIG="$HOME/.config/i3/colors.conf"
cat > "$I3_CONFIG" <<EOF
# Auto-generated i3 colors
client.focused          $I3_FOCUSED_BORDER $I3_FOCUSED_BG $I3_FOCUSED_TEXT $I3_FOCUSED_INDICATOR
client.focused_inactive $I3_INACTIVE_BORDER $I3_INACTIVE_BG $I3_INACTIVE_TEXT $I3_INACTIVE_INDICATOR
client.unfocused        $I3_UNFOCUSED_BORDER $I3_UNFOCUSED_BG $I3_UNFOCUSED_TEXT
client.urgent           $I3_URGENT_BORDER $I3_URGENT_BG #ffffff #ff0000

# Gaps
gaps inner $GAPS_INNER
gaps outer $GAPS_OUTER

# Border
default_border pixel $BORDER_WIDTH
EOF

# Reload i3 if running
if pgrep -x i3 > /dev/null; then
    i3-msg "reload" 2>/dev/null
fi

# ═══════════════════════════════════════════════════════════════════════
# APPLY KITTY COLORS
# ═══════════════════════════════════════════════════════════════════════

KITTY_COLORS="$HOME/.config/kitty/theme-colors.conf"
cat > "$KITTY_COLORS" <<EOF
# ═══════════════════════════════════════════════════════════════════════
# KITTY THEME COLORS - $THEME_NAME MODE
# ═══════════════════════════════════════════════════════════════════════

foreground              $TERM_FG
background              $TERM_BG
selection_foreground    $TERM_BG
selection_background    $TERM_CURSOR

cursor                  $TERM_CURSOR
cursor_text_color       $TERM_CURSOR_TEXT

url_color               $COLOR_SECONDARY

active_tab_foreground   #ffffff
active_tab_background   $COLOR_ACCENT
inactive_tab_foreground $COLOR_ACCENT_LIGHT
inactive_tab_background $COLOR_BG_ALT

color0  $TERM_BLACK
color8  $TERM_BRIGHT_BLACK
color1  $TERM_RED
color9  $TERM_BRIGHT_RED
color2  $TERM_GREEN
color10 $TERM_BRIGHT_GREEN
color3  $TERM_YELLOW
color11 $TERM_BRIGHT_YELLOW
color4  $TERM_BLUE
color12 $TERM_BRIGHT_BLUE
color5  $TERM_MAGENTA
color13 $TERM_BRIGHT_MAGENTA
color6  $TERM_CYAN
color14 $TERM_BRIGHT_CYAN
color7  $TERM_WHITE
color15 $TERM_BRIGHT_WHITE

background_opacity $TERM_OPACITY
EOF

# Reload kitty if running (send SIGUSR1 to reload config)
if pgrep -x kitty > /dev/null; then
    killall -SIGUSR1 kitty 2>/dev/null
fi

# ═══════════════════════════════════════════════════════════════════════
# APPLY POLYBAR COLORS (via environment variables in launch.sh)
# ═══════════════════════════════════════════════════════════════════════

# Just restart polybar to pick up new colors
if pgrep -x polybar > /dev/null; then
    ~/.config/polybar/launch.sh &
fi

# ═══════════════════════════════════════════════════════════════════════
# APPLY ROFI COLORS
# ═══════════════════════════════════════════════════════════════════════

ROFI_THEME="$HOME/.config/rofi/theme.rasi"
mkdir -p "$HOME/.config/rofi"
cat > "$ROFI_THEME" <<EOF
* {
    bg: $ROFI_BG;
    bg-alt: $ROFI_BG_ALT;
    fg: $ROFI_FG;
    accent: $ROFI_ACCENT;
    urgent: $ROFI_URGENT;
    
    background-color: @bg;
    text-color: @fg;
}

window {
    transparency: "real";
    background-color: @bg;
    border: 2px;
    border-color: @accent;
    border-radius: 12px;
    width: 600px;
    location: center;
}

mainbox {
    padding: 20px;
    background-color: transparent;
}

inputbar {
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 10px 15px;
    margin-bottom: 15px;
    children: [entry];
}

entry {
    background-color: transparent;
    text-color: @fg;
    placeholder: "Search...";
    placeholder-color: @fg;
}

listview {
    background-color: transparent;
    columns: 1;
    spacing: 5px;
    fixed-height: false;
    dynamic: true;
}

element {
    background-color: transparent;
    padding: 10px 15px;
    border-radius: 8px;
}

element selected {
    background-color: @accent;
    text-color: #ffffff;
}

element urgent {
    background-color: @urgent;
}
