#!/bin/sh
# Core loader for shell configuration
# This script loads all dotfiles components in the correct order

# Get the directory of this script
DOTFILES_DIR="${HOME}/.dotfiles"
SHELL_DIR="${DOTFILES_DIR}/shell"

# Load environment variables first
if [ -f "${SHELL_DIR}/env/exports.sh" ]; then
  . "${SHELL_DIR}/env/exports.sh"
fi

if [ -f "${SHELL_DIR}/env/path.sh" ]; then
  . "${SHELL_DIR}/env/path.sh"
fi

# Load OS-specific configuration
case "$(uname -s)" in
  Darwin)
    if [ -f "${SHELL_DIR}/env/macos.sh" ]; then
      . "${SHELL_DIR}/env/macos.sh"
    fi
    ;;
  Linux)
    if [ -f "${SHELL_DIR}/env/linux.sh" ]; then
      . "${SHELL_DIR}/env/linux.sh"
    fi
    ;;
esac

# Load aliases
for alias_file in "${SHELL_DIR}/aliases"/*.sh; do
  if [ -f "$alias_file" ] && [ -r "$alias_file" ]; then
    . "$alias_file"
  fi
done

# Load functions
for func_file in "${SHELL_DIR}/functions"/*.sh; do
  if [ -f "$func_file" ] && [ -r "$func_file" ]; then
    . "$func_file"
  fi
done

# Load prompt last
if [ -f "${SHELL_DIR}/prompt/prompt.sh" ]; then
  . "${SHELL_DIR}/prompt/prompt.sh"
fi
