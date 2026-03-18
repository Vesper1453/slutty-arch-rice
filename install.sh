#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════╗
# ║              SLUTTY ARCH RICE - INSTALL SCRIPT 💋🔥🍆                     ║
# ║    Sets up the complete multi-mode Arch Linux rice configuration        ║
# ╚══════════════════════════════════════════════════════════════════════════╝

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQUIRED_PACKAGES=(
    # Window Manager
    "i3-gaps"           # Tiling window manager with gaps
    "polybar"           # Status bar
    "rofi"              # Application launcher
    "picom"             # Compositor for transparency
    "dunst"             # Notification daemon
    
    # Terminal & Shell
    "alacritty"         # GPU-accelerated terminal
    "zsh"               # Z shell
    "oh-my-zsh-git"     # Oh My Zsh framework
    
    # Utilities
    "feh"               # Image viewer/wallpaper setter
    "flameshot"         # Screenshot tool
    "betterlockscreen"  # Lock screen
    "brightnessctl"     # Brightness control
    "pactl"             # PulseAudio control
    "volumeicon"        # Volume tray icon
    "network-manager-applet"  # Network tray icon
    "ttf-jetbrains-mono-nerd"  # Nerd Font
    "ttf-font-awesome"  # Font Awesome icons
    "papirus-icon-theme" # Icon theme
    
    # Optional but recommended
    "neofetch"          # System info display
    "htop"              # System monitor
    "ranger"            # File manager
    "mpv"               # Video player
    "imagemagick"       # Image manipulation
)

# ═══════════════════════════════════════════════════════════════════════════
# COLORS FOR OUTPUT
# ═══════════════════════════════════════════════════════════════════════════

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_banner() {
    echo -e "${MAGENTA}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════════╗
║                                                                          ║
║     💋  SLUTTY ARCH RICE INSTALLER  💋                                     ║
║                                                                          ║
║     🍆 DEGENERATE MODE  |  🔥 HORNY MODE  |  💼 NORMAL MODE              ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

print_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ═══════════════════════════════════════════════════════════════════════════
# INSTALLATION FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_warning "This installer is designed for Arch Linux!"
        read -p "Continue anyway? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

install_packages() {
    print_info "Installing required packages..."
    
    # Update package database
    sudo pacman -Sy
    
    # Check for yay or paru
    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    else
        print_warning "No AUR helper found. Installing yay..."
        
        # Install yay
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
        AUR_HELPER="yay"
    fi
    
    # Install packages from official repos
    print_info "Installing packages from official repositories..."
    sudo pacman -S --needed --noconfirm i3-gaps polybar rofi picom dunst alacritty \
        feh flameshot betterlockscreen brightnessctl pavucontrol \
        volumeicon network-manager-applet \
        ttf-jetbrains-mono-nerd ttf-font-awesome papirus-icon-theme \
        neofetch htop ranger mpv imagemagick 2>/dev/null || {
        print_warning "Some packages may have failed to install. Continuing..."
    }
    
    # Install packages from AUR
    print_info "Installing AUR packages..."
    $AUR_HELPER -S --needed --noconfirm oh-my-zsh-git 2>/dev/null || {
        print_warning "oh-my-zsh-git failed to install. You can install it manually later."
    }
    
    print_success "Package installation complete!"
}

backup_configs() {
    print_info "Backing up existing configurations..."
    
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    local configs=("i3" "polybar" "rofi" "alacritty" "picom" "dunst")
    for config in "${configs[@]}"; do
        if [[ -d "$HOME/.config/$config" ]]; then
            cp -r "$HOME/.config/$config" "$backup_dir/"
            print_info "Backed up $config"
        fi
    done
    
    if [[ -n $(ls -A "$backup_dir" 2>/dev/null) ]]; then
        print_success "Backups saved to $backup_dir"
    else
        rmdir "$backup_dir"
        print_info "No existing configs to backup"
    fi
}

install_dotfiles() {
    print_info "Installing dotfiles..."
    
    # Create .config directory structure
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    
    # Copy configurations
    cp -r "$DOTFILES_DIR/.config/"* "$HOME/.config/"
    cp -r "$DOTFILES_DIR/.local/bin/"* "$HOME/.local/bin/"
    
    # Copy themes directory
    if [[ -d "$HOME/dotfiles" ]]; then
        mv "$HOME/dotfiles" "$HOME/dotfiles-old" 2>/dev/null || true
    fi
    cp -r "$DOTFILES_DIR" "$HOME/dotfiles"
    
    # Make scripts executable
    chmod +x "$HOME/.local/bin/switch-mode"
    chmod +x "$HOME/.local/bin/set-wallpaper"
    chmod +x "$HOME/.config/polybar/launch.sh"
    
    print_success "Dotfiles installed!"
}

install_wallpapers() {
    print_info "Setting up wallpapers..."
    
    # Create wallpaper directories
    mkdir -p "$HOME/dotfiles/themes/degenerate/wallpapers"
    mkdir -p "$HOME/dotfiles/themes/horny/wallpapers"
    mkdir -p "$HOME/dotfiles/themes/normal/wallpapers"
    
    # Generate simple gradient wallpapers as placeholders
    print_info "Generating placeholder wallpapers..."
    
    # Generate degenerate mode wallpaper (deep purple to hot pink gradient)
    convert -size 1920x1080 "gradient:#1a0a2e-#ff1493" \
        -pointsize 30 -fill "#ffb6c1" -gravity center \
        -annotate +0+0 "💋 DEGENERATE MODE 💋" \
        "$HOME/dotfiles/themes/degenerate/wallpapers/degenerate-gradient.png" 2>/dev/null || {
        print_warning "ImageMagick convert failed. Skipping wallpaper generation."
    }
    
    # Generate horny mode wallpaper (maroon to orange gradient)
    convert -size 1920x1080 "gradient:#2e0a1a-#ff4500" \
        -pointsize 30 -fill "#ffa07a" -gravity center \
        -annotate +0+0 "🔥 HORNY MODE 🔥" \
        "$HOME/dotfiles/themes/horny/wallpapers/horny-gradient.png" 2>/dev/null || true
    
    # Generate normal mode wallpaper (dark blue to light blue gradient)
    convert -size 1920x1080 "gradient:#1e1e2e-#89b4fa" \
        -pointsize 30 -fill "#cdd6f4" -gravity center \
        -annotate +0+0 "💼 NORMAL MODE 💼" \
        "$HOME/dotfiles/themes/normal/wallpapers/normal-gradient.png" 2>/dev/null || true
    
    print_success "Wallpapers ready! Add your own images to ~/dotfiles/themes/*/wallpapers/"
}

configure_zsh() {
    print_info "Configuring Zsh..."
    
    # Set zsh as default shell
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        print_info "Changing default shell to Zsh..."
        chsh -s /bin/zsh
    fi
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
            print_warning "Oh My Zsh installation failed. You can install it manually."
        }
    fi
    
    print_success "Zsh configured!"
}

update_path() {
    print_info "Updating PATH..."
    
    # Add ~/.local/bin to PATH if not present
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        print_success "Added ~/.local/bin to PATH"
    fi
}

print_next_steps() {
    echo -e "${GREEN}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════════╗
║                                                                          ║
║                    💋 INSTALLATION COMPLETE! 💋                          ║
║                                                                          ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                          ║
║  NEXT STEPS:                                                             ║
║                                                                          ║
║  1. Log out and log back in (or reboot)                                  ║
║  2. Select 'i3' as your window manager at login                          ║
║  3. Open a terminal (Mod+Return)                                         ║
║  4. Run 'switch-mode --help' to see available modes                      ║
║                                                                          ║
║  MODE SWITCHING:                                                          ║
║  • switch-mode degenerate   💋🔥🍆 Maximum slut energy                   ║
║  • switch-mode horny         🔥💦 Warm, flirty vibe                       ║
║  • switch-mode normal       💼✨ Professional, clean                    ║
║  • Mod+Shift+m              Opens mode switcher menu                       ║
║                                                                          ║
║  KEYBINDINGS:                                                            ║
║  • Mod+Return               Open terminal                                ║
║  • Mod+d                   Open app launcher                             ║
║  • Mod+q                   Close window                                    ║
║  • Mod+Shift+e             Exit i3                                        ║
║  • Mod+[1-0]               Switch workspace                              ║
║  • Mod+Shift+[1-0]         Move window to workspace                      ║
║  • Mod+r                   Resize mode                                   ║
║  • Mod+f                   Toggle fullscreen                               ║
║                                                                          ║
║  CUSTOMIZATION:                                                          ║
║  • Add wallpapers to ~/dotfiles/themes/*/wallpapers/                     ║
║  • Edit configs in ~/.config/ or ~/dotfiles/.config/                     ║
║  • Modify colors in the theme files                                       ║
║                                                                          ║
║  Have fun, slut! 💋🔥🍆                                                  ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

# ═══════════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════════

main() {
    print_banner
    
    check_arch
    
    print_info "This will install the Slutty Arch Rice configuration."
    print_info "This includes i3 window manager, polybar, rofi, and more."
    echo
    
    read -p "Continue with installation? [Y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        backup_configs
        install_packages
        install_dotfiles
        install_wallpapers
        configure_zsh
        update_path
        print_next_steps
    else
        print_info "Installation cancelled."
        exit 0
    fi
}

# Run main function
main "$@"
