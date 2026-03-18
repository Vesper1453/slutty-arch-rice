#!/usr/bin/env bash

# MPRIS Player Display for Polybar
# Shows currently playing track with slutty flair 💋

player_status=$(playerctl status 2>/dev/null)

if [ $? -eq 0 ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    
    if [ "$player_status" = "Playing" ]; then
        icon="▶️"
    else
        icon="⏸️"
    fi
    
    # Truncate if too long
    max_len=40
    full_text="$artist - $title"
    if [ ${#full_text} -gt $max_len ]; then
        full_text="${full_text:0:$max_len}..."
    fi
    
    echo "$icon $full_text 💋"
else
    echo "🎵 Nothing playing... 💤"
fi
