# Linux-specific configuration

# System update alias
alias update='sudo apt update && sudo apt upgrade -y'

# Check for required tools
has_curl=$(command -v curl >/dev/null 2>&1 && echo true || echo false)
has_unzip=$(command -v unzip >/dev/null 2>&1 && echo true || echo false)
has_fc_list=$(command -v fc-list >/dev/null 2>&1 && echo true || echo false)

# Install Oh My Posh if not present
if ! command -v oh-my-posh >/dev/null 2>&1; then
  echo "Installing Oh My Posh..."
  if [ "$has_curl" = true ]; then
    curl -s https://ohmyposh.dev/install.sh | bash
  else
    echo "curl not found. Please install Oh My Posh manually: https://ohmyposh.dev/docs/installation"
  fi
fi

# Ensure oh-my-posh is installed and in the PATH first
if command -v oh-my-posh &> /dev/null; then
  echo "Installing Nerd Font for Oh My Posh..."
  
  # 'Meslo' is the recommended default, but you can change this to 'FiraCode', etc.
  oh-my-posh font install Meslo --headless
  
  echo "Font installation complete."
else
  echo "Error: oh-my-posh not found. Please install the binary before installing fonts."
fi

# Install Nerd Font if not present
# if [ "$has_fc_list" = true ] && ! fc-list | grep -q "Nerd Font" 2>/dev/null; then
#   echo "Installing Fira Code Nerd Font..."
#   mkdir -p ~/.fonts
#   if [ "$has_curl" = true ] && [ "$has_unzip" = true ]; then
#     curl -L -o ~/.fonts/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
#     unzip -o ~/.fonts/FiraCode.zip -d ~/.fonts/
#     rm ~/.fonts/FiraCode.zip
#     fc-cache -f ~/.fonts/
#   else
#     echo "curl or unzip not found. Please install a Nerd Font manually for proper icon rendering."
#   fi
# elif [ "$has_fc_list" != true ]; then
#   echo "fontconfig not installed. Please install fontconfig and a Nerd Font manually for proper icon rendering."
# fi
