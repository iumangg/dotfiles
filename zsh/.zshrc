# Zsh configuration

# Load dotfiles
if [ -f "${HOME}/.dotfiles/shell/load.sh" ]; then
  . "${HOME}/.dotfiles/shell/load.sh"
fi

# Zsh-specific settings
setopt autocd 2>/dev/null || true

# End of zsh configuration