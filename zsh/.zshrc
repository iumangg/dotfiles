files_to_source=("aliases.zsh" "functions.zsh")
for file in "${files_to_source[@]}"; do
  [ -f "$file" ] && source "./.dotfiles/zsh/$file"
done