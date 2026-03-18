#!/bin/bash
# ╔═══════════════════════════════════════════════════════════════════════════
[truncated]
dotfiles" ]]; then
        log_error "Dotfiles directory not found at $DOTFILES_DIR"
        exit 1
    fi
    
    log_info "Backing up existing configs to $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
    
    for config in .config/{i3,polybar,rofi,alacritty,picom,dunst,i3status,betterlockscreen,neofetch} .oh-my-zsh .local/bin; do
        if [[ -e "$HOME/$config" && ! -L "$HOME/$config" ]]; then
            log_info "Backing up $config..."
            cp -r "$HOME/$config" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done
}

# Install dependencies
install_dependencies() {
    log_info "Installing dependencies..."
    
    # Detect package manager
    if command -v pacman &>/dev/null; then
        # Arch Linux
        sudo pacman -S --needed --noconfirm \
            i3-wm i3status i3lock polybar rofi alacritty picom dunst \
            feh nitrogen mpv ffmpeg imagemagick \
            zsh zsh-completions curl wget git \
            xclip xdotool brightnessctl volumeicon \
            network-manager-applet pavucontrol \
            yt-dlp python-pip betterlockscreen \
            exiftool perl-image-exiftool rclone || {
            log_warn "Some packages may have failed to install"
        }
        
    elif command -v apt &>/dev/null; then
        # Debian/Ubuntu
        sudo apt update
        sudo apt install -y \
            i3-wm i3status suckless-tools polybar rofi alacritty picom dunst \
            feh nitrogen mpv ffmpeg imagemagick \
            zsh curl wget git \
            xclip xdotool brightnessctl volumeicon \
            network-manager-gnome pavucontrol || {
            log_warn "Some packages may have failed to install"
        }
        
    else
        log_warn "Unknown package manager. Please install dependencies manually."
    fi
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
    fi
}

# Create symlinks for configs
link_configs() {
    log_info "Linking configurations..."
    
    # Create necessary directories
    mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.oh-my-zsh/custom/themes" "$HOME/Stash"
    
    # Link config directories
    for dir in i3 polybar rofi alacritty picom dunst i3status betterlockscreen neofetch; do
        if [[ -d "$DOTFILES_DIR/.config/$dir" ]]; then
            rm -rf "$HOME/.config/$dir" 2>/dev/null || true
            ln -sf "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
            log_success "Linked .config/$dir"
        fi
    done
    
    # Link individual scripts
    for script in "$DOTFILES_DIR"/.local/bin/*; do
        if [[ -f "$script" ]]; then
            script_name=$(basename "$script")
            rm -f "$HOME/.local/bin/$script_name" 2>/dev/null || true
            ln -sf "$script" "$HOME/.local/bin/$script_name"
        fi
    done
    log_success "Linked .local/bin scripts"
    
    # Link theme files
    rm -rf "$HOME/.config/themes" 2>/dev/null || true
    ln -sf "$DOTFILES_DIR/themes" "$HOME/.config/themes"
    log_success "Linked themes directory"
}

# Install custom zsh theme
install_zsh_theme() {
    log_info "Installing slutty zsh theme..."
    
    if [[ -f "$DOTFILES_DIR/.oh-my-zsh/custom/themes/slutty-arch.zsh-theme" ]]; then
        cp "$DOTFILES_DIR/.oh-my-zsh/custom/themes/slutty-arch.zsh-theme" \
           "$HOME/.oh-my-zsh/custom/themes/"
        log_success "Installed slutty-arch.zsh-theme"
    fi
    
    # Update .zshrc to use the theme
    if [[ -f "$HOME/.zshrc" ]]; then
        sed -i 's/ZSH_THEME=.*/ZSH_THEME="slutty-arch"/' "$HOME/.zshrc" 2>/dev/null || true
        log_success "Updated ZSH_THEME in .zshrc"
    fi
}

# Set up default mode
setup_default_mode() {
    log_info "Setting up default mode..."
    
    mkdir -p "$HOME/.config"
    echo "normal" > "$HOME/.config/arch-rice-mode"
    
    # Initialize cum counter
    echo "0" > "$HOME/.cum-count"
    
    log_success "Default mode set to NORMAL (use 'switch-mode degenerate' to get filthy 💋)"
}

# Post-install message
install_complete() {
    echo ""
    banner
    echo ""
    log_success "💋 SLUTTY ARCH RICE INSTALLED! 💋"
    echo ""
    echo -e "${PINK}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${PINK}║  ${WHITE}QUICK START:${RESET}                                                   ${PINK}║${RESET}"
    echo -e "${PINK}║  ${YELLOW}• Restart i3:${RESET} Mod+Shift+r                                       ${PINK}║${RESET}"
    echo -e "${PINK}║  ${YELLOW}• Switch modes:${RESET} Mod+Shift+m                                       ${PINK}║${RESET}"
    echo -e "${PINK}║  ${YELLOW}• Degenerate menu:${RESET} Mod+Shift+b                                  ${PINK}║${RESET}"
    echo -e "${PINK}║  ${YELLOW}• Terminal porn:${RESET} Mod+Shift+v                                      ${PINK}║${RESET}"
    echo -e "${PINK}║  ${YELLOW}• PANIC BUTTON:${RESET} Mod+Shift+Escape 🚨                            ${PINK}║${RESET}"
    echo -e "${PINK}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    log_info "Run 'switch-mode degenerate' to activate maximum slut energy! 🔥🍆"
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════
# MAIN ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════

main() {
    check_prerequisites
    banner
    
    echo ""
    read -p "💋 Ready to get slutty? (y/N): " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { log_info "Aborted. Stay pure I guess 💼"; exit 0; }
    
    backup_existing
    install_dependencies
    link_configs
    install_zsh_theme
    setup_default_mode
    install_complete
}

main "$@"
