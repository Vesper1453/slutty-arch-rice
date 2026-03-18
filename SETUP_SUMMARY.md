# 💋 SLUTTY ARCH RICE - Complete Setup Summary

## 📦 Installation Files

### Core Configuration Files

| File | Description | Lines |
|------|-------------|-------|
| `.config/i3/config` | Main i3 window manager config | 241 |
| `.config/i3/mode.conf` | Mode-specific colors (auto-generated) | ~30 |
| `.config/polybar/config.ini` | Status bar configuration | 324 |
| `.config/polybar/launch.sh` | Polybar launcher script | 25 |
| `.config/rofi/config.rasi` | Application launcher styling | 90 |
| `.config/alacritty/alacritty.yml` | Terminal configuration | 104 |
| `.config/picom/picom.conf` | Compositor (transparency/blur) | 164 |
| `.config/dunst/dunstrc` | Notification daemon config | 106 |
| `.config/i3status/config` | Fallback status bar | 40 |
| `.config/neofetch/config.conf` | System info display | 200 |
| `.config/betterlockscreen/betterlockscreenrc` | Lock screen styling | 40 |

### Theme Files

| Mode | File | Purpose |
|------|------|---------|
| **Degenerate** 💋 | `themes/degenerate/polybar/config.ini` | Hot pink status bar |
| **Degenerate** 💋 | `themes/degenerate/theme.conf` | i3 color scheme |
| **Horny** 🔥 | `themes/horny/polybar/config.ini` | Orange-red status bar |
| **Horny** 🔥 | `themes/horny/alacritty.yml` | Warm terminal colors |
| **Horny** 🔥 | `themes/horny/rofi.rasi` | Flirty launcher theme |
| **Horny** 🔥 | `themes/horny/theme.conf` | i3 color scheme |
| **Normal** 💼 | `themes/normal/polybar/config.ini` | Blue professional bar |
| **Normal** 💼 | `themes/normal/alacritty.yml` | Clean terminal colors |
| **Normal** 💼 | `themes/normal/rofi.rasi` | Professional launcher |
| **Normal** 💼 | `themes/normal/theme.conf` | i3 color scheme |

### Utility Scripts

| Script | Purpose | Lines |
|--------|---------|-------|
| `.local/bin/switch-mode` | Main mode switcher | 380 |
| `.local/bin/set-wallpaper` | Wallpaper setter | 80 |
| `.local/bin/setup-wallpapers` | Generate gradient wallpapers | 150 |
| `.local/bin/lock-screen` | Mode-aware lock screen | 50 |
| `.local/bin/update-mode-lockscreen` | Update lock colors | 70 |
| `.local/bin/rice-check` | Health check script | 200 |
| `install.sh` | Installation script | 350 |

### Zsh Theme

| File | Description |
|------|-------------|
| `.oh-my-zsh/custom/themes/slutty-arch.zsh-theme` | Mode-aware Zsh prompt with colors |

## 🎨 Color Schemes

### DEGENERATE Mode 💋🔥🍆
```
Background:     #1a0a2e (Deep Purple)
Background Alt: #2d0f4e (Dark Purple)
Foreground:     #ffb6c1 (Light Pink)
Primary:        #ff1493 (Hot Pink)
Secondary:      #ff0066 (Deep Pink)
Accent:         #ff00ff (Magenta)
Urgent:         #ff0000 (Red)
```

### HORNY Mode 🔥💦
```
Background:     #2e0a1a (Maroon)
Background Alt: #4e152d (Dark Maroon)
Foreground:     #ffa07a (Light Salmon)
Primary:        #ff4500 (Orange Red)
Secondary:      #ff6347 (Tomato)
Accent:         #ff8c00 (Dark Orange)
Urgent:         #dc143c (Crimson)
```

### NORMAL Mode 💼✨
```
Background:     #1e1e2e (Dark Blue-Gray)
Background Alt: #313244 (Gray)
Foreground:     #cdd6f4 (Light Blue-White)
Primary:        #89b4fa (Light Blue)
Secondary:      #cba6f7 (Lavender)
Accent:         #fab387 (Peach)
Urgent:         #f38ba8 (Pink)
```

## 🪟 Transparency Settings

| Mode | Inactive Opacity | Active Opacity | Blur Strength |
|------|------------------|----------------|---------------|
| DEGENERATE | 80% | 92% | 5 |
| HORNY | 85% | 93% | 5 |
| NORMAL | 88% | 95% | 5 |

All windows have:
- 12px corner radius
- Soft drop shadows
- Dual Kawase blur effect
- Fade animations on focus change

## 📐 Gap Settings

| Mode | Inner Gaps | Outer Gaps |
|------|------------|------------|
| DEGENERATE | 15px | 5px |
| HORNY | 10px | 3px |
| NORMAL | 8px | 0px |

## ⌨️ Keybindings

### Navigation
| Key | Action |
|-----|--------|
| `Mod+Return` | Open terminal |
| `Mod+d` | Open app launcher (Rofi) |
| `Mod+Shift+m` | Open mode switcher |
| `Mod+q` | Close window |
| `Mod+[1-0]` | Switch workspace |
| `Mod+Shift+[1-0]` | Move window to workspace |
| `Mod+h/j/k/l` | Focus window |
| `Mod+Shift+h/j/k/l` | Move window |
| `Mod+r` | Resize mode |
| `Mod+f` | Toggle fullscreen |
| `Mod+Shift+e` | Exit i3 |

### System
| Key | Action |
|-----|--------|
| `Mod+x` | Lock screen |
| `Print` | Full screenshot |
| `Mod+Print` | Area screenshot |
| `Mod+Shift+c` | Reload i3 config |
| `Mod+Shift+r` | Restart i3 |

## 🖼️ Wallpaper Directories

```
themes/
├── degenerate/wallpapers/   # 💋 Hot pink/purple images
├── horny/wallpapers/        # 🔥 Warm red/orange images
└── normal/wallpapers/       # 💼 Blue/professional images
```

Use `setup-wallpapers` to generate gradient wallpapers for all modes.

## 🔧 Mode Switching

### Command Line
```bash
switch-mode degenerate   # 💋 Maximum slut energy
switch-mode horny        # 🔥 Warm and flirty
switch-mode normal       # 💼 Professional clean
```

### Interactive Menu
Press `Mod+Shift+m` to open the mode switcher menu.

### What Changes
1. i3 window border colors
2. Polybar status bar colors
3. Alacritty terminal colors
4. Rofi launcher colors
5. Dunst notification colors
6. Picom transparency levels
7. Wallpaper (random from mode folder)
8. Lock screen colors

## 📋 Installation Checklist

- [ ] Copy dotfiles to `~/dotfiles/`
- [ ] Run `cd ~/dotfiles && ./install.sh`
- [ ] Log out and select 'i3' as window manager
- [ ] Run `switch-mode normal` to set initial mode
- [ ] Run `setup-wallpapers` to generate wallpapers
- [ ] Add custom wallpapers to theme folders
- [ ] Test all three modes
- [ ] Customize colors if desired

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| Polybar not showing | Run `~/.config/polybar/launch.sh` |
| No transparency | Check `picom` is running: `pgrep picom` |
| Mode not switching | Run `rice-check` to diagnose |
| Missing fonts | Install `ttf-jetbrains-mono-nerd` |
| Lock screen wrong colors | Run `update-mode-lockscreen` |

## 📝 File Permissions

All scripts are executable (`chmod +x`):
- `install.sh`
- `.local/bin/*`
- `.config/polybar/launch.sh`

## 💖 Made With

- 💋 Love for customization
- 🔥 Passion for aesthetics
- 🍆 Commitment to slutty excellence

---

**Version:** 1.0.0  
**Total Files:** 40+  
**Total Lines of Config:** 2000+  
**Slut Energy:** Maximum 💋
