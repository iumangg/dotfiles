# Oh My Posh prompt configuration

# Check if oh-my-posh is available
if command -v oh-my-posh >/dev/null 2>&1; then
  # Initialize Oh My Posh based on shell
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(oh-my-posh init zsh --config ~/.dotfiles/config/oh-my-posh/minimal.omp.yaml)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(oh-my-posh init bash --config ~/.dotfiles/config/oh-my-posh/minimal.omp.yaml)"
  fi
fi
