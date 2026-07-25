# Bash configuration

# Load dotfiles
if [ -f "${HOME}/.dotfiles/shell/load.sh" ]; then
  . "${HOME}/.dotfiles/shell/load.sh"
fi

# Bash-specific settings
shopt -s autocd 2>/dev/null || true

# End of the bash configuration