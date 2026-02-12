#!/bin/bash
# 현재 기기의 설정을 저장소로 역방향 동기화

DOTFILES="$HOME/dotfiles"

echo "🔄 역방향 동기화를 시작합니다..."
echo ""

# Homebrew 패키지 목록 동기화
echo "📦 Homebrew 패키지 목록 동기화 중..."
brew bundle dump --file="$DOTFILES/brew/Brewfile" --force
echo "  Brewfile 업데이트 완료"
echo ""

# VS Code 확장 목록 동기화
echo "💻 VS Code 확장 목록 동기화 중..."
code --list-extensions > "$DOTFILES/vscode/extensions.txt"
echo "  extensions.txt 업데이트 완료"
echo ""

# 변경사항 확인
echo "============================================"
echo "✅ 동기화 완료. 변경사항을 확인하세요:"
echo ""
cd "$DOTFILES" && git status --short
echo ""
echo "커밋하려면:"
echo "  cd ~/dotfiles"
echo "  git add --all"
echo "  git commit -m \"동기화\""
echo "============================================"
