#!/bin/bash
# SLUTTY ARCH RICE - ONE COMMAND INSTALLER
# This script sets up the entire degenerate rice automatically

set -e

# Colors for pretty output
PINK='\033[38;5;213m'
RED='\033[38;5;196m'
PURPLE='\033[38;5;141m'
YELLOW='\033[38;5;220m'
GREEN='\033[38;5;82m'
WHITE='\033[97m'
RESET='\033[0m'

# Logging functions
log_info() { echo -e "${PURPLE}💋${RESET} $1"; }
log_success() { echo -e "${GREEN}✓${RESET} $1"; }
log_warn() { echo -e "${YELLOW}⚠${RESET} $1"; }
log_error() { echo -e "${RED}✗${RESET} $1"; }

# Banner
banner() {
    echo -e "${PINK}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  💋 SLUTTY ARCH RICE - ONE COMMAND INSTALLER 💋            ║"
    echo "║  Multi-mode desktop: DEGENERATE | HORNY | NORMAL         ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
}

# Check prerequisites - handles both piped and local execution
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Detect if script was piped (no proper file location)
    if [[ "$0" == "/dev/stdin" ]] || [[ "$0" == "bash" ]] || [[ ! -f "$0" ]]; then
        log_info "Script piped from curl - downloading full repository..."
        
        # Clone the repo
        REPO_URL="https://github.com/Vesper1453/slutty-arch-rice.git"
        INSTALL_DIR="$HOME/slutty-arch-rice"
        
        # Remove old install if exists
        [[ -d "$INSTALL_DIR" ]] && rm -rf "$INSTALL_DIR"
        
        git clone "$REPO_URL" "$INSTALL_DIR" || {
            log_error "Failed to clone repository. Trying with curl..."
            # Fallback: download zip
            curl -fsSL "https://github.com/Vesper1453/slutty-arch-rice/archive/refs/heads/main.zip" -o /tmp/slutty-arch-rice.zip
            cd /tmp && unzip -q slutty-arch-rice.zip
            mv /tmp/slutty-arch-rice-main "$INSTALL_DIR"
        }
        
        DOTFILES_DIR="$INSTALL_DIR"
        
        log_success "Repository downloaded to: $DOTFILES_DIR"
        log_info "Continuing setup from downloaded repo..."
        
        # Re-run the setup from the downloaded location
        cd "$DOTFILES_DIR"
        exec bash "$DOTFILES_DIR/setup.sh" "${@}"
    else
        # Normal execution - script is a file
        DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
    fi
    
    export DOTFILES_DIR
    log_success "Dotfiles directory: $DOTFILES_DIR"
}

# Backup existing configs
backup_existing() {
    local BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_info "Backing up existing configs to $BACKUP_DIR..."
        mkdir -p "$BACKUP_DIR"
        
        for config in .config/{i3,polybar,rofi,alacritty,picom,dunst} .local/bin; do
            if [[ -e "$HOME/$config" && ! -L "$HOME/$config" ]]; then
                cp -r "$HOME/$config" "$BACKUP_DIR/" 2>/dev/null || true
            fi
        done
    fi
}

# Install dependencies with better error handling
install_dependencies() {
    log_info "Detecting distribution..."
    
    # Check if running EndeavourOS
    if [[ -f /etc/os-release ]] && grep -q "EndeavourOS" /etc/os-release; then
        log_info "💜 EndeavourOS detected!"
        log_info "Installing i3 + gaps and all required packages..."
        
        # Update first
        sudo pacman -Syu --noconfirm || log_warn "Some updates failed, continuing..."
        
        # Install all needed packages
        sudo pacman -S --needed --noconfirm i3-wm i3-gaps i3status polybar rofi alacritty picom dunst feh mpv zsh curl git wget || {
            log_warn "Some packages failed - trying without i3-gaps..."
            sudo pacman -S --needed --noconfirm i3-wm i3status polybar rofi alacritty picom dunst feh mpv zsh curl git
        }
        
        # Check if yay is installed (AUR helper)
        if ! command -v yay &>/dev/null; then
            log_info "Installing yay (AUR helper)..."
            git clone https://aur.archlinux.org/yay.git /tmp/yay
            cd /tmp/yay && makepkg -si --noconfirm
            cd -
        fi
        
        log_success "EndeavourOS packages installed!"
        
    elif command -v pacman &>/dev/null; then
        log_info "Arch Linux detected (pacman)"
        log_info "Installing packages..."
        sudo pacman -Syu --noconfirm || log_warn "System update failed, continuing..."
        sudo pacman -S --needed --noconfirm i3-wm i3status polybar rofi alacritty picom dunst feh mpv zsh curl git wget || {
            log_warn "Some packages failed to install - you may need to install manually"
            log_info "Required: i3-wm, polybar, rofi, alacritty, picom, dunst, feh, mpv, zsh"
        }
    elif command -v apt &>/dev/null; then
        log_info "Debian/Ubuntu detected (apt)"
        log_info "Installing packages..."
        sudo apt update || log_warn "Update failed, continuing..."
        sudo apt install -y i3-wm i3status suckless-tools polybar rofi alacritty compton dunst feh mpv zsh curl git wget || {
            log_warn "Some packages failed - trying alternatives..."
            sudo apt install -y i3-wm i3status rofi alacritty compton dunst feh mpv zsh curl git
        }
    elif command -v dnf &>/dev/null; then
        log_info "Fedora detected (dnf)"
        sudo dnf install -y i3 i3status polybar rofi alacritty picom dunst feh mpv zsh curl git
    else
        log_warn "Unknown distribution - please install dependencies manually"
        log_info "Required packages: i3-wm, polybar, rofi, alacritty, picom, dunst, feh, mpv, zsh"
    fi
}

# Link configs
link_configs() {
    log_info "Linking configurations..."
    
    mkdir -p "$HOME/.config" "$HOME/.local/bin"
    
    for dir in i3 polybar rofi alacritty picom dunst; do
        if [[ -d "$DOTFILES_DIR/.config/$dir" ]]; then
            rm -rf "$HOME/.config/$dir" 2>/dev/null || true
            ln -sf "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
            log_success "Linked .config/$dir"
        fi
    done
    
    for script in "$DOTFILES_DIR"/.local/bin/*; do
        if [[ -f "$script" ]]; then
            script_name=$(basename "$script")
            rm -f "$HOME/.local/bin/$script_name" 2>/dev/null || true
            ln -sf "$script" "$HOME/.local/bin/$script_name"
        fi
    done
    log_success "Linked all scripts"
}

# Setup complete
install_complete() {
    echo ""
    banner
    echo ""
    log_success "SLUTTY ARCH RICE INSTALLED!"
    echo ""
    echo -e "${PINK}QUICK START:${RESET}"
    echo "  • Restart i3: Mod+Shift+r"
    echo "  • Switch modes: Mod+Shift+m"
    echo "  • Degenerate menu: Mod+Shift+b"
    echo "  • PANIC BUTTON: Mod+Shift+Escape"
    echo ""
    log_info "Run 'switch-mode degenerate' for maximum slut energy!"
}

# Main
main() {
    check_prerequisites
    banner
    read -p "Ready to get slutty? (y/N): " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || exit 0
    backup_existing
    install_dependencies
    link_configs
    install_complete
}

main "$@"
