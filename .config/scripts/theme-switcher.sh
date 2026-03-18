#!/usr/bin/env bash

# ═══════════════════════════════════════════════════════════════════════
# THEME SWITCHER - Interactive theme selector
# ═══════════════════════════════════════════════════════════════════════

THEME_DIR="$HOME/.config/rice"
THEME_CONFIG="$THEME_DIR/current-theme.conf"
DOTFILES_DIR="$HOME/.config"

# Ensure directories exist
mkdir -p "$THEME_DIR"

# ═══════════════════════════════════════════════════════════════════════
# SHOW MENU
# ═══════════════════════════════════════════════════════════════════════

show_menu() {
    choice=$(printf "🔥 DEGENERATE MODE (Ultimate Slut)\n😈 HORNY MODE (Seductive)\n💼 NORMAL MODE (Professional)\nCancel" | rofi -dmenu -p "Select Theme" -theme "$DOTFILES_DIR/rofi/theme.rasi")
    
    case "$choice" in
        "🔥 DEGENERATE MODE (Ultimate Slut)")
            set_theme "degenerate"
            ;;
        "😈 HORNY MODE (Seductive)")
            set_theme "horny"
            ;;
        "💼 NORMAL MODE (Professional)")
            set_theme "normal"
            ;;
        *)
            exit 0
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════
# SET THEME
# ═══════════════════════════════════════════════════════════════════════

set_theme() {
    mode="$1"
    
    echo "💋 Switching to $mode mode..."
    
    # Copy theme config
    cp "$HOME/.config/themes/$mode/theme.conf" "$THEME_CONFIG"
    
    # Update polybar mode indicator
    case "$mode" in
        "degenerate")
            echo "🔥 DEGENERATE" > "$DOTFILES_DIR/polybar/current-mode.txt"
            notify-send -t 3000 "💋 Theme Changed" "Welcome to DEGENERATE mode, you filthy slut!"
            ;;
        "horny")
            echo "😈 HORNY" > "$DOTFILES_DIR/polybar/current-mode.txt"
            notify-send -t 3000 "💖 Theme Changed" "HORNY mode activated. Feeling seductive?"
            ;;
        "normal")
            echo "💼 NORMAL" > "$DOTFILES_DIR/polybar/current-mode.txt"
            notify-send -t 3000 "💻 Theme Changed" "NORMAL mode. Back to business."
            ;;
    esac
    
    # Reload theme
    source "$THEME_CONFIG"
    
    # Apply to all components
    apply_i3_theme
    apply_kitty_theme
    apply_polybar_theme
    apply_wallpaper
    apply_picom
    
    echo "✨ Theme applied successfully!"
}

# ═══════════════════════════════════════════════════════════════════════
# APPLY I3 THEME
# ═══════════════════════════════════════════════════════════════════════

apply_i3_theme() {
    source "$THEME_CONFIG"
    
    # Generate i3 color config
    cat > "$DOTFILES_DIR/i3/colors.conf" <<EOF
# $THEME_NAME Theme Colors
client.focused          $I3_FOCUSED_BORDER $I3_FOCUSED_BG $I3_FOCUSED_TEXT $I3_FOCUSED_INDICATOR $I3_FOCUSED_BORDER
client.focused_inactive $I3_INACTIVE_BORDER $I3_INACTIVE_BG $I3_INACTIVE_TEXT $I3_INACTIVE_INDICATOR $I3_INACTIVE_BORDER
client.unfocused        $I3_UNFOCUSED_BORDER $I3_UNFOCUSED_BG $I3_UNFOCUSED_TEXT $I3_UNFOCUSED_BORDER $I3_UNFOCUSED_BORDER
client.urgent           $I3_URGENT_BORDER $I3_URGENT_BG #ffffff $I3_URGENT_BORDER $I3_URGENT_BORDER

# Gaps
gaps inner $GAPS_INNER
gaps outer $GAPS_OUTER

# Borders
default_border pixel $BORDER_WIDTH
hide_edge_borders smart_no_gaps

# Window opacity
for_window [class=".*"] opacity $I3_OPACITY
EOF
    
    # Reload i3
    if command -v i3-msg &> /dev/null; then
        i3-msg "reload" 2>/dev/null
    fi
}

# ═══════════════════════════════════════════════════════════════════════
# APPLY KITTY THEME
# ═══════════════════════════════════════════════════════════════════════

apply_kitty_theme() {
    source "$THEME_CONFIG"
    
    cat > "$DOTFILES_DIR/kitty/theme-colors.conf" <<EOF
# $THEME_NAME Theme Colors
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
    
    # Reload kitty
    if pgrep -x kitty > /dev/null; then
        killall -SIGUSR1 kitty 2>/dev/null || true
    fi
}

# ═══════════════════════════════════════════════════════════════════════
# APPLY POLYBAR THEME
# ═══════════════════════════════════════════════════════════════════════

apply_polybar_theme() {
    # Export theme colors as environment variables
    source "$THEME_CONFIG"
    
    export POLY_BG POLY_FG POLY_ACCENT POLY_ACCENT_ALT
    export POLY_CPU POLY_RAM POLY_NET POLY_VOL POLY_BAT POLY_TIME POLY_DATE
    
    # Restart polybar
    ~/.config/polybar/launch.sh &
}

# ═══════════════════════════════════════════════════════════════════════
# APPLY WALLPAPER
# ═══════════════════════════════════════════════════════════════════════

apply_wallpaper() {
    source "$THEME_CONFIG"
    
    # Generate solid color wallpaper if no image exists
    wallpaper_path="$DOTFILES_DIR/wallpapers/current.jpg"
    
    if [ ! -f "$wallpaper_path" ]; then
        # Create gradient wallpaper using ImageMagick
        if command -v convert &> /dev/null; then
            convert -size 1920x1080 "gradient:$COLOR_BG-$COLOR_BG_ALT" "$wallpaper_path" 2>/dev/null || true
        fi
    fi
    
    # Set wallpaper
    if command -v feh &> /dev/null; then
        feh --bg-scale "$wallpaper_path" 2>/dev/null || true
    elif command -v nitrogen &> /dev/null; then
        nitrogen --set-zoom-fill "$wallpaper_path" 2>/dev/null || true
    fi
}

# ═══════════════════════════════════════════════════════════════════════
# APPLY PICOM COMPOSITOR SETTINGS
# ═══════════════════════════════════════════════════════════════════════

apply_picom() {
    source "$THEME_CONFIG"
    
    # Generate picom config with theme-appropriate transparency
    cat > "$DOTFILES_DIR/picom.conf" <<EOF
# Picom configuration - $THEME_NAME Mode
backend = "glx"
vsync = true

# Opacity
opacity-rule = [
    "95:class_g = 'kitty'",
    "90:class_g = 'Polybar'",
    "85:class_g = 'Rofi'"
];

# Blur
blur-method = "dual_kawase";
blur-strength = 8;

# Corners
corner-radius = $CORNER_RADIUS;
rounded-corners-exclude = [
    "class_g = 'i3bar'",
    "window_type = 'dock'"
];

# Shadows
shadow = true;
shadow-radius = 12;
shadow-opacity = 0.75;
shadow-offset-x = -7;
shadow-offset-y = -7;

# Fading
fading = true;
fade-delta = 5;
fade-in-step = 0.03;
fade-out-step = 0.03;

# Animation
animations = true;
animation-for-transient-window = "slide";
animation-for-open-window = "grow";
animation-for-unmap-window = "shrink";
EOF
    
    # Restart picom
    if pgrep -x picom > /dev/null; then
        killall picom 2>/dev/null
        sleep 0.5
    fi
    
    picom --config "$DOTFILES_DIR/picom.conf" &
}

# ═══════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════

# Check if called with argument
if [ -n "$1" ]; then
    case "$1" in
        "degenerate"|"horny"|"normal")
            set_theme "$1"
            ;;
        *)
            echo "Usage: $0 [degenerate|horny|normal]"
            exit 1
            ;;
    esac
else
    # Show interactive menu
    show_menu
fi
