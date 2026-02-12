#!/bin/bash
# Homebrew 설치 및 패키지 설치

echo "🍺 Homebrew 설정 중..."

# Homebrew 설치
echo "Homebrew 설치 중..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon Mac의 경우 PATH 설정
if [[ $(uname -m) == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 분석 수집 비활성화
brew analytics off

# Brewfile로 패키지 설치
brew bundle --file="$DOTFILES/brew/Brewfile"

echo "✅ Homebrew 패키지 설치 완료"
