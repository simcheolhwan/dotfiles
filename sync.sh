#!/bin/bash
# 현재 기기의 설정을 저장소로 역방향 동기화

DOTFILES="$HOME/dotfiles"

source "$DOTFILES/profile.sh"

echo "🔄 역방향 동기화를 시작합니다..."
echo "📋 프로파일: $DOTFILES_PROFILE"
echo ""

# Homebrew 패키지 목록 동기화
echo "📦 Homebrew 패키지 목록 동기화 중..."
PROFILE_BREWFILE="$DOTFILES/brew/Brewfile.$DOTFILES_PROFILE"
brew bundle dump --file="$PROFILE_BREWFILE" --force

# personal이면 공통/work 항목 제외
if is_profile "personal"; then
  tmp=$(mktemp)
  grep -v -x -F -f "$DOTFILES/brew/Brewfile" "$PROFILE_BREWFILE" \
    | grep -v -x -F -f "$DOTFILES/brew/Brewfile.work" > "$tmp"
  mv "$tmp" "$PROFILE_BREWFILE"
fi

echo "  $PROFILE_BREWFILE 업데이트 완료"
echo "  ⚠️  공통 패키지는 brew/Brewfile에 수동 정리 필요"
echo ""

# VS Code 확장 목록 동기화
echo "💻 VS Code 확장 목록 동기화 중..."
code --list-extensions > "$DOTFILES/vscode/extensions.txt"
echo "  extensions.txt 업데이트 완료"
echo ""

# Moom Classic 설정 동기화 (서버 제외)
if ! is_profile "server"; then
  if defaults read com.manytricks.Moom &>/dev/null; then
    defaults export com.manytricks.Moom "$DOTFILES/moom/com.manytricks.Moom.plist"
    plutil -convert xml1 "$DOTFILES/moom/com.manytricks.Moom.plist"
    echo "  Moom Classic 설정 업데이트 완료"
  fi
fi
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
