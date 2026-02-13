#!/bin/bash
DOTFILES_PROFILE_FILE="$HOME/.dotfiles-profile"

if [ -f "$DOTFILES_PROFILE_FILE" ]; then
  DOTFILES_PROFILE=$(cat "$DOTFILES_PROFILE_FILE")
else
  echo "❌ 프로파일 미설정. ./install.sh --profile=personal|work|server 를 먼저 실행하세요."
  exit 1
fi

export DOTFILES_PROFILE

is_profile() {
  [ "$DOTFILES_PROFILE" = "$1" ]
}
