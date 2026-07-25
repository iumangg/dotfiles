# macOS-specific configuration

# Setup Homebrew if available
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup JAVA_HOME if Java is installed
if [ -x "/usr/libexec/java_home" ]; then
  export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
fi

# Check for Homebrew availability
has_brew=$(command -v brew >/dev/null 2>&1 && echo true || echo false)

# Install Oh My Posh if not present
if ! command -v oh-my-posh >/dev/null 2>&1; then
  if [ "$has_brew" = true ]; then
    echo "Installing Oh My Posh via Homebrew..."
    brew install oh-my-posh
  else
    echo "Homebrew not found. Please install Oh My Posh manually: https://ohmyposh.dev/docs/installation"
  fi
fi

# check if font is already installed before trying to install it again
if ! system_profiler SPFontsDataType | grep -q "MesloLGS Nerd Font"; then
  if command -v oh-my-posh &> /dev/null; then
    echo "Installing Nerd Font for Oh My Posh..."
    # 'Meslo' is the recommended default, but you can change this to 'FiraCode', etc.
    oh-my-posh font install Meslo --headless
    echo "Font installation complete."
  else
    echo "Error: oh-my-posh not found. Please install the binary before installing fonts."
  fi
fi
