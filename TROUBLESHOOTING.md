# 🔧 TROUBLESHOOTING - Nothing Changed?

## Most Common Issue: Not Running i3

### Check What Desktop You're On:
```bash
# What window manager is running?
echo $XDG_CURRENT_DESKTOP

# Or check processes
ps aux | grep -E "(i3|kwin|mutter|xfwm)" | grep -v grep
```

**If you see KDE, GNOME, XFCE, etc. = You're not in i3!**

---

## 🚀 Switch to i3 at Login

### Step 1: Logout
Click logout/shutdown in your current desktop.

### Step 2: At Login Screen
1. Click the **gear icon** (session selector)
2. Select **"i3"** or **"i3 (with gaps)"**
3. Login

**You should see a black screen with a status bar = i3 is running!**

---

## 🧪 Quick Test (Without Logging Out)

If you want to test i3 without switching:
```bash
# Start i3 in a nested window (Xephyr)
sudo pacman -S xorg-server-xephyr
Xephyr :1 -screen 1280x720 &
sleep 2
DISPLAY=:1 i3
```

---

## 📋 Manual Setup (If Script Failed)

```bash
# 1. Go to dotfiles directory
cd ~/slutty-arch-rice

# 2. Manually link configs
mkdir -p ~/.config ~/.local/bin
ln -sf ~/slutty-arch-rice/.config/i3 ~/.config/i3
ln -sf ~/slutty-arch-rice/.config/polybar ~/.config/polybar
ln -sf ~/slutty-arch-rice/.config/rofi ~/.config/rofi
ln -sf ~/slutty-arch-rice/.config/alacritty ~/.config/alacritty
ln -sf ~/slutty-arch-rice/.config/picom ~/.config/picom
ln -sf ~/slutty-arch-rice/.config/dunst ~/.config/dunst

# 3. Link scripts
for script in ~/slutty-arch-rice/.local/bin/*; do
    ln -sf "$script" ~/.local/bin/$(basename "$script")
done

# 4. Verify
echo "Configs linked. Logout and select i3!"
```

---

## 🖼️ Visual Confirmation

**When i3 + Slutty Rice is WORKING:**
- Window borders are colored (pink/red/blue)
- Top status bar shows "💋 DEGENERATE MODE 💋"
- Press `Mod+Enter` opens pink terminal
- Press `Mod+Shift+m` shows mode switcher
- Windows have gaps between them

**If you see plain gray windows = Not working!**

---

## 🆘 Still Not Working?

Run these and tell me the output:
```bash
# Check if i3 is installed
i3 --version

# Check if config exists
ls -la ~/.config/i3/

# Check if in i3 now
pgrep -x i3

# Check for errors
~/.local/bin/verify-rice
```

**Then message me the results!** 💋
