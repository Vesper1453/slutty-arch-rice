# 🍆 DEGENERATE TOOLKIT - Porn & Hentai Command Center 💋

**Welcome to the ultimate adult content management system for Linux!**

This toolkit transforms your Degenerate Mode into a fully-featured **Porn & Hentai Command Center** with specialized tools for downloading, organizing, viewing, and managing your collection.

---

## 🎯 Quick Reference

| Tool | Keybinding | Purpose |
|------|------------|---------|
| **degenerate-menu** | `Mod+Shift+b` | Browser bookmarks for adult sites |
| **porn-organizer** | `Mod+Shift+o` | Sort your collection |
| **hentai-viewer** | `Mod+Shift+h` | Manga/doujinshi reader |
| **terminal-porn-viewer** | `Mod+Shift+v` | Watch porn in your terminal |
| **stash-launcher** | `Mod+Shift+s` | Start Stash server |
| **metadata-cleaner** | `Mod+Shift+t` | Strip identifying info |
| **porn-downloader** | `Mod+Shift+d` | Download from tube sites |
| **privacy-wipe** | `Mod+Shift+w` | Deep clean all traces |
| **duplicate-finder** | `Mod+Shift+f` | Find duplicate files |
| **thumbnail-generator** | `Mod+Shift+g` | Create preview gallery |
| **panic-button** | `Mod+Shift+Escape` | Emergency mode switch |

---

## 📥 DOWNLOAD TOOLS

### porn-downloader
**Wrapper for yt-dlp optimized for adult tube sites**

```bash
# Interactive mode
porn-downloader

# Direct download
porn-downloader "https://..."

# Specific quality
porn-downloader -q 1080p "https://..."

# Download playlist
porn-downloader -p "https://.../playlist"

# Audio only (for ASMR)
porn-downloader -a "https://..."

# With cookies for authenticated sites
porn-downloader -c ~/.cookies.txt "https://..."
```

**Features:**
- Automatic quality selection
- Playlist support
- Cookie authentication
- Parallel fragment downloads
- Metadata embedding control

---

### gallery-scraper (via gallery-dl)
**Download galleries from boorus and image boards**

Install: `sudo pacman -S gallery-dl`

```bash
# Download from Gelbooru
gallery-dl "https://gelbooru.com/index.php?page=post&s=view&id=..."

# Download entire tag
gallery-dl "https://gelbooru.com/index.php?page=post&s=list&tags=..."

# Download from Danbooru
gallery-dl "https://danbooru.donmai.us/posts/..."

# Specific config for hentai
gallery-dl --config ~/.config/gallery-dl/hentai.conf "URL"
```

**Supported Sites:**
- Gelbooru, Danbooru, Safebooru
- E621, Rule34
- Luscious, Hentai-Foundry
- Pixiv, Twitter

---

## 🗂️ ORGANIZATION TOOLS

### porn-organizer
**Automatically sort your collection by type, date, or performer**

```bash
# Organize by file type (default)
porn-organizer ~/Downloads ~/Stash type

# Organize by date
porn-organizer ~/Downloads ~/Stash date

# Organize alphabetically
porn-organizer ~/Downloads ~/Stash performer
```

**Organization Structure:**
```
~/Stash/
├── Videos/
│   ├── 2024/
│   │   ├── 01/
│   │   └── 02/
├── Images/
└── Comics/
```

**Features:**
- Automatic file type detection
- Progress reporting
- Duplicate handling
- Directory tree visualization

---

### duplicate-finder
**Find and clean up duplicate files**

```bash
# Scan collection
duplicate-finder ~/Stash

# With minimum size
duplicate-finder ~/Stash 5M

# Interactive review mode
duplicate-finder review
```

**Features:**
- Fast scanning with rmlint
- Interactive review
- Calculates wasted space
- Generates deletion script

---

### thumbnail-generator
**Create preview thumbnails for your collection**

```bash
# Generate thumbnails
thumbnail-generator ~/Stash ~/Thumbs

# Custom size and quality
thumbnail-generator ~/Stash ~/Thumbs 300 90

# Create HTML gallery
thumbnail-generator gallery
```

**Features:**
- Video frame extraction (middle frame)
- Image resizing
- Directory structure preservation
- HTML gallery generation
- Progress tracking

---

## 🎬 MEDIA PLAYERS

### hentai-viewer
**Optimized manga/doujinshi reader**

```bash
# Launch with default directory
hentai-viewer

# Specific manga folder
hentai-viewer ~/Stash/Comics/"Series Name"

# Shows recent reading sessions
```

**Features:**
- Keyboard navigation (Space/Backspace)
- Fullscreen by default
- Reading progress tracking
- Rofi integration for manga selection
- CBZ/CBR support (with mcomix)

**Keybindings in imv:**
- `Space/Right` - Next page
- `Backspace/Left` - Previous page
- `f` - Fullscreen toggle
- `r` - Rotate
- `q` - Quit

---

### mpv (recommended)
**The best video player for your collection**

```bash
# Basic playback
mpv video.mp4

# With slutty config
mpv --config-dir=~/.config/mpv video.mp4

# Playlist
mpv playlist.m3u

# Streaming
mpv "https://..."
```

**Features:**
- Hardware acceleration
- Lua scripting support
- Custom keybindings
- Minimal UI

---

## 🗃️ DATABASE & SERVERS

### stash-launcher
**Self-hosted adult content organizer**

```bash
# Start Stash server
stash-launcher start

# Check status
stash-launcher status

# Open in browser
stash-launcher open

# Trigger library scan
stash-launcher scan

# Generate thumbnails
stash-launcher generate

# Backup database
stash-launcher backup

# Update to latest version
stash-launcher update

# View logs
stash-launcher logs
```

**Stash Features:**
- Web-based UI at `http://localhost:9999`
- Automatic metadata scraping
- Tag-based organization
- Transcoding support
- Mobile-friendly interface
- Plugin system

**First Setup:**
1. Run `stash-launcher start`
2. Open `http://localhost:9999`
3. Configure library path to `/data`
4. Let it scan your collection!

---

## 🔒 PRIVACY TOOLS

### metadata-cleaner
**Strip EXIF data and identifying info**

```bash
# Clean single file
metadata-cleaner photo.jpg

# Clean video
metadata-cleaner video.mp4

# Recursive cleaning
metadata-cleaner -r ~/Stash

# Dry run (preview only)
metadata-cleaner -d ~/Stash

# Verify cleaning
metadata-cleaner -v ~/Stash
```

**Removes:**
- EXIF data (GPS, camera info, timestamps)
- Video metadata (creation dates, software tags)
- Thumbnail previews
- Comment fields

**Supports:**
- Images: JPG, PNG, GIF, WebP
- Videos: MP4, MKV, AVI, MOV, WebM

---

### privacy-wipe
**Nuclear option for removing all traces**

```bash
# Standard wipe
privacy-wipe

# With secure deletion
privacy-wipe --secure-wipe --wipe-dir ~/Stash
```

**What it clears:**
1. ✅ All browser histories (Firefox, Chrome, Brave, Qutebrowser)
2. ✅ Clipboard data
3. ✅ Recent files (GTK, KDE, thumbnails)
4. ✅ Shell history (porn-related commands)
5. ✅ System caches
6. ✅ Temp files
7. ✅ Optionally: Secure-delete files (shred)

**Confirmation required:** Type `NUCLEAR` to confirm!

---

## 🛠️ HELPER UTILITIES

### yt-dlp configs
**Location:** `~/.config/yt-dlp/porn.conf`

Pre-configured for:
- Best quality selection
- Concurrent downloads
- Geo-bypass
- User-agent spoofing

### gallery-dl configs
**Location:** `~/.config/gallery-dl/config.json`

Pre-configured for:
- Booru sites (Gelbooru, Danbooru, E621)
- Cookie support
- Filename templates

---

## 📋 INSTALLATION

Install all dependencies:

```bash
sudo pacman -S --needed \
    yt-dlp \
    gallery-dl \
    mpv \
    imv \
    ffmpeg \
    imagemagick \
    perl-image-exiftool \
    rmlint \
    fdupes \
    exiftool \
    bleachbit \
    docker \
    docker-compose
```

For Stash (Docker):
```bash
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Logout and login again
```

---

## 🎨 INTEGRATION WITH DEGENERATE MODE

All tools are automatically available in **DEGENERATE MODE**:

1. **Status Bar Widgets:**
   - 🥛 CUM COUNTER (click to check)
   - 💧 WETNESS METER (Horny mode)
   - 🚨 PANIC BUTTON (click to activate)

2. **Keybindings:** All `Mod+Shift+<key>` bindings listed above

3. **Notifications:** Slutty notifications for all actions

4. **Terminal Aliases:**
   - `cum` - Increment cum counter
   - `cumcount` - Check count
   - `stash` - Launch Stash
   - `organize` - Run porn-organizer

---

## 🔐 SECURITY RECOMMENDATIONS

1. **Use LUKS encryption** for your Stash directory:
   ```bash
   sudo cryptsetup luksFormat /dev/sdX
   sudo cryptsetup open /dev/sdX stash
   mkfs.ext4 /dev/mapper/stash
   ```

2. **Enable Stash authentication** in settings

3. **Use privacy-wipe** after each session

4. **Configure Tor** for anonymous browsing:
   ```bash
   sudo pacman -S tor
   sudo systemctl enable --now tor
   # Use with: torsocks firefox
   ```

5. **Set up firewall rules**:
   ```bash
   sudo ufw default deny incoming
   sudo ufw allow 9999/tcp  # Stash only from localhost
   ```

---

## 💡 PRO TIPS

1. **Use workspaces strategically:**
   - `2:🌐 PORN` - Browser with adult sites
   - `10:🍆 CUM` - Downloads and Stash

2. **Combine tools for efficiency:**
   ```bash
   porn-downloader "URL" && porn-organizer ~/Downloads ~/Stash
   ```

3. **Set up cron for automatic organization:**
   ```bash
   # Organize downloads every hour
   0 * * * * /home/$USER/.local/bin/porn-organizer ~/Downloads ~/Stash type
   ```

4. **Use the panic button often:** `Mod+Shift+Escape`

5. **Keep your cum counter updated** - track your productivity! 🥛

---

## 🆘 TROUBLESHOOTING

**Issue:** `yt-dlp: command not found`  
**Fix:** `sudo pacman -S yt-dlp`

**Issue:** Stash won't start  
**Fix:** `sudo systemctl start docker && stash-launcher restart`

**Issue:** Thumbnails not generating  
**Fix:** Check ffmpeg: `ffmpeg -version`

**Issue:** Metadata cleaner failing  
**Fix:** Install exiftool: `sudo pacman -S perl-image-exiftool`

---

## 💋 HAPPY DEGENERACY! 💋

Your Linux desktop is now a fully-featured **Porn & Hentai Command Center**!

**Remember:** Use `Mod+Shift+Escape` when someone walks in! 🚨

---

*Total Tools: 10 specialized utilities*  
*Total Keybindings: 20+ shortcuts*  
*Slut Energy: MAXIMUM* 🔥
