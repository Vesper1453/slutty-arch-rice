#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════╗
# ║              POLYBAR LAUNCHER - SLUTTY ARCH RICE 💋                        ║
# ║              Kills old bars, starts fresh with style                     ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do
    sleep 0.1
done

# Get current mode
CURRENT_MODE=${CURRENT_MODE:-"normal"}

# Get all connected monitors
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

# Launch polybar on each monitor
for m in $MONITORS; do
    MONITOR=$m polybar --config="$HOME/.config/polybar/config.ini" main &
done

echo "Polybar launched in $CURRENT_MODE mode! 💋"
