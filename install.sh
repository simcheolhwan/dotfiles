#!/bin/bash

DOTFILES="$HOME/dotfiles"

echo "🚀 dotfiles 설치를 시작합니다..."
echo ""

# 1. Homebrew 설치 및 패키지 설치
echo "📦 [1/9] Homebrew 및 패키지 설치"
chmod +x "$DOTFILES/brew/setup.sh"
source "$DOTFILES/brew/setup.sh"
echo ""

# 2. 심볼릭 링크 생성
echo "🔗 [2/9] 심볼릭 링크 생성"
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
echo "  ~/.zshrc → dotfiles/zsh/.zshrc"

ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
echo "  ~/.gitconfig → dotfiles/git/.gitconfig"

ln -sf "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"
echo "  ~/.gitignore_global → dotfiles/git/.gitignore_global"

ln -sf "$DOTFILES/claude" "$HOME/.claude"
echo "  ~/.claude → dotfiles/claude"

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_DIR"
ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
echo "  VS Code settings.json 연결 완료"
ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
echo "  VS Code keybindings.json 연결 완료"
echo ""

# 3. oh-my-zsh 설치
echo "🐚 [3/9] oh-my-zsh 설치"
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "  oh-my-zsh 설치 완료"
echo ""

# 4. Powerlevel10k 설치
echo "🎨 [4/9] Powerlevel10k 테마 설치"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
echo "  Powerlevel10k 설치 완료"
echo ""

# 5. zsh 플러그인 설치
echo "🔌 [5/9] zsh 플러그인 설치"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
echo "  zsh-autosuggestions 설치 완료"

git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
echo "  zsh-syntax-highlighting 설치 완료"
echo ""

# 6. nvm 및 Node.js 설치
echo "📗 [6/9] nvm 및 Node.js 설치"
export NVM_DIR="$HOME/.nvm"
NVM_LATEST=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
echo "  nvm 및 최신 LTS Node.js 설치 완료"
echo ""

# 7. VS Code 확장 설치
echo "💻 [7/9] VS Code 확장 설치"
CODE_CMD="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
EXTENSIONS_FILE="$DOTFILES/vscode/extensions.txt"
while IFS= read -r extension; do
  [ -z "$extension" ] && continue
  "$CODE_CMD" --install-extension "$extension" --force
done < "$EXTENSIONS_FILE"
echo "  VS Code 확장 설치 완료"
echo ""

# 8. macOS 설정 적용
echo "🍎 [8/9] macOS 설정 적용"
chmod +x "$DOTFILES/macos/defaults.sh"
source "$DOTFILES/macos/defaults.sh"
echo ""

# 9. 파일 연결 설정
echo "🔗 [9/9] 파일 연결 설정"
chmod +x "$DOTFILES/macos/duti.sh"
source "$DOTFILES/macos/duti.sh"
echo ""

# 완료
echo "============================================"
echo "✅ dotfiles 설치가 완료되었습니다!"
echo ""
echo "다음 작업을 수행해 주세요:"
echo "  1. 터미널을 재시작하거나 'source ~/.zshrc' 실행"
echo "  2. iTerm2에서 설정 디렉토리를 ~/dotfiles/iterm2/로 지정"
echo "  3. 필요 시 git/.gitconfig에 사용자 정보 입력"
echo "============================================"
