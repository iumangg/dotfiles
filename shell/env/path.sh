# Add dotfiles and local binary directories to PATH
if [ -n "${HOME:-}" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.dotfiles/bin:${PATH:-}"
else
  export PATH="${PATH:-}"
fi
