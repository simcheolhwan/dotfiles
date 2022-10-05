CURRENT="~/dotfiles"
echo "source $CURRENT/.zshrc" >> ~/.zshrc
echo "[include]\n  path = $CURRENT/git/.gitconfig" >> ~/.gitconfig
