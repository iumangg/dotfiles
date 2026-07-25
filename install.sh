#!/bin/bash
# Dotfiles installer
# This script installs the dotfiles repository to ~/.dotfiles

set -euo pipefail

DOTFILES_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DEST="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles/backup/$(date +%Y%m%d_%H%M%S)"

log() {
  echo "🔧 $1"
}

error() {
  echo "❌ $1" >&2
  exit 1
}

# Create backup directory if needed
create_backup_dir() {
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    log "Created backup directory: $BACKUP_DIR"
  fi
}

# Backup existing file or symlink
backup_file() {
  local file="$1"
  if [ -e "$file" ] || [ -L "$file" ]; then
    create_backup_dir
    mv "$file" "$BACKUP_DIR/"
    log "Backed up $file to $BACKUP_DIR/"
  fi
}

# Copy directories to destination
install_directories() {
  local dirs=("shell" "zsh" "bash" "bin" "config")

  for dir in "${dirs[@]}"; do
    if [ -d "$DOTFILES_SRC/$dir" ]; then
      cp -r "$DOTFILES_SRC/$dir" "$DOTFILES_DEST/"
      log "Copied $dir/ to $DOTFILES_DEST/"
    else
      error "Directory $dir not found in source"
    fi
  done
}

# Create symlinks for dotfiles
create_symlinks() {
  local files=(".zshrc" ".bashrc")

  for file in "${files[@]}"; do
    case "$file" in
      .zshrc) subdir="zsh" ;;
      .bashrc) subdir="bash" ;;
      *) error "Unknown file $file" ;;
    esac
    local src="$DOTFILES_DEST/$subdir/$file"
    local dest="$HOME/$file"

    if [ -L "$dest" ]; then
      # Check if symlink points to correct location
      if [ "$(readlink "$dest")" = "$src" ]; then
        log "Symlink $dest already correct, skipping"
        continue
      else
        backup_file "$dest"
      fi
    elif [ -e "$dest" ]; then
      backup_file "$dest"
    fi

    ln -s "$src" "$dest"
    log "Created symlink: $dest -> $src"
  done
}

# Main installation
main() {
  log "Starting dotfiles installation..."

  # Create destination directory if it doesn't exist
  if [ ! -d "$DOTFILES_DEST" ]; then
    mkdir -p "$DOTFILES_DEST"
    log "Created $DOTFILES_DEST"
  fi

  # Install directories
  install_directories

  # Create symlinks
  create_symlinks

  log "Installation complete! 🎉"
  log "You may need to restart your shell or run 'source ~/.zshrc' or 'source ~/.bashrc'"
}

main "$@"