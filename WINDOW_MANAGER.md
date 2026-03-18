# 🪟 WINDOW MANAGER: i3/i3-gaps

## Why i3? (Not Hyprland)

This slutty Arch rice uses **i3/i3-gaps** - the tried-and-true tiling window manager that's been stable for over a decade!

### ✅ Why i3 is Better for This Rice

| Feature | i3/i3-gaps | Hyprland |
|---------|------------|----------|
| **Stability** | 🟢 Rock-solid | 🟡 Still maturing |
| **Documentation** | 🟢 Extensive | 🟡 Growing |
| **Community** | 🟢 Massive | 🟡 Smaller |
| **Mode Switching** | 🟢 Perfect for our 3-mode system | 🟡 Complicated |
| **Transparency** | 🟢 Works great with picom | 🟢 Native but buggy |
| **Polybar** | 🟢 Full support | 🟢 Works but config differs |
| **Ease of Use** | 🟢 Simple config | 🟡 More complex |
| **Wayland** | 🔴 X11 only | 🟢 Wayland native |

### 🎯 What We're Using

```
Window Manager: i3-gaps (X11)
Status Bar:     Polybar
Compositor:     Picom (for transparency)
Display:        Xorg
```

### 📦 Installation

```bash
# Install i3-gaps
sudo pacman -S i3-gaps polybar picom rofi alacritty

# Or use the install script:
cd ~/dotfiles
./install.sh
```

### 🚀 Starting i3

**From TTY (no display manager):**
```bash
exec i3
```

**With a display manager (ly, lightdm, etc):**
Select "i3" from the session menu.

### 🎨 i3 Keybindings

| Key | Action |
|-----|--------|
| `Mod+Return` | Open terminal |
| `Mod+d` | Open rofi launcher |
| `Mod+Shift+m` | Mode switcher (DEGENERATE/HORNY/NORMAL) |
| `Mod+[1-0]` | Switch workspace |
| `Mod+Shift+q` | Close window |
| `Mod+f` | Fullscreen |
| `Mod+r` | Resize mode |

### 🔧 Troubleshooting i3

**Issue:** Config errors on startup  
**Fix:** Check config with `i3 -C -c ~/.config/i3/config`

**Issue:** Gaps not working  
**Fix:** Make sure you installed `i3-gaps`, not `i3`

**Issue:** Polybar not showing  
**Fix:** Run `~/.config/polybar/launch.sh` manually to see errors

**Issue:** No transparency  
**Fix:** Check picom is running: `pgrep picom`

### 🔄 Switching to Hyprland (If You Really Want)

If you INSIST on Hyprland despite the warnings:

1. Backup your dotfiles
2. Install Hyprland: `sudo pacman -S hyprland`
3. Rewrite configs for Hyprland syntax
4. Note: Many scripts will need updating
5. Good luck! 🍀

**We recommend staying with i3 for maximum stability!** 💋

---

**TL;DR:** This rice uses **i3-gaps + Xorg + Picom** - a proven stable combo! No Hyprland here! 🚫
