#!/bin/bash
# dotfiles 설치 점검 스크립트

DOTFILES="$HOME/dotfiles"

source "$DOTFILES/profile.sh"

pass_count=0
fail_count=0

green='\033[0;32m'
red='\033[0;31m'
bold='\033[1m'
reset='\033[0m'

pass() {
  echo -e "  ${green}✓${reset} $1"
  ((pass_count++))
}

fail() {
  echo -e "  ${red}✗${reset} $1"
  ((fail_count++))
}

section() {
  echo -e "\n${bold}$1${reset}"
}

check_symlink() {
  local target="$1"
  local expected="$2"
  local label="$3"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$expected" ]; then
    pass "$label"
  else
    fail "$label"
  fi
}

check_defaults() {
  local domain="$1"
  local key="$2"
  local expected="$3"
  local label="$4"
  local actual
  actual=$(defaults read "$domain" "$key" 2>/dev/null)
  if [ "$actual" = "$expected" ]; then
    pass "$label"
  else
    fail "$label (기대: $expected, 현재: $actual)"
  fi
}

echo "🔍 dotfiles 설치 상태를 점검합니다..."
echo "📋 프로파일: $DOTFILES_PROFILE"

# Homebrew

section "Homebrew"

if command -v brew &>/dev/null; then
  pass "brew 설치됨 ($(brew --version | head -1))"
  if brew bundle check --file="$DOTFILES/brew/Brewfile" &>/dev/null; then
    pass "Brewfile 패키지 모두 설치됨"
  else
    fail "Brewfile 패키지 누락"
  fi

  if is_profile "personal"; then
    if brew bundle check --file="$DOTFILES/brew/Brewfile.work" &>/dev/null; then
      pass "Brewfile.work 패키지 모두 설치됨"
    else
      fail "Brewfile.work 패키지 누락"
    fi
  fi

  PROFILE_BREWFILE="$DOTFILES/brew/Brewfile.$DOTFILES_PROFILE"
  if [ -f "$PROFILE_BREWFILE" ]; then
    if brew bundle check --file="$PROFILE_BREWFILE" &>/dev/null; then
      pass "Brewfile.$DOTFILES_PROFILE 패키지 모두 설치됨"
    else
      fail "Brewfile.$DOTFILES_PROFILE 패키지 누락"
    fi
  fi
else
  fail "brew 설치되지 않음"
fi

# 심볼릭 링크

section "심볼릭 링크"

check_symlink "$HOME/.zshrc" "$DOTFILES/zsh/.zshrc" "~/.zshrc"
check_symlink "$HOME/.gitconfig" "$DOTFILES/git/.gitconfig" "~/.gitconfig"
check_symlink "$HOME/.gitignore_global" "$DOTFILES/git/.gitignore_global" "~/.gitignore_global"
check_symlink "$HOME/.claude" "$DOTFILES/claude" "~/.claude"

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
check_symlink "$VSCODE_DIR/settings.json" "$DOTFILES/vscode/settings.json" "VS Code settings.json"
check_symlink "$VSCODE_DIR/keybindings.json" "$DOTFILES/vscode/keybindings.json" "VS Code keybindings.json"

# 셸 환경

section "셸 환경"

if [ "$SHELL" = "/bin/zsh" ]; then
  pass "기본 셸: zsh"
else
  fail "기본 셸: $SHELL (zsh 아님)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ -d "$HOME/.oh-my-zsh" ]; then
  pass "oh-my-zsh 설치됨"
else
  fail "oh-my-zsh 설치되지 않음"
fi

if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  pass "Powerlevel10k 설치됨"
else
  fail "Powerlevel10k 설치되지 않음"
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  pass "zsh-autosuggestions 설치됨"
else
  fail "zsh-autosuggestions 설치되지 않음"
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  pass "zsh-syntax-highlighting 설치됨"
else
  fail "zsh-syntax-highlighting 설치되지 않음"
fi

# Node.js

section "Node.js"

if ! is_profile "server"; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  if command -v nvm &>/dev/null; then
    pass "nvm 설치됨 ($(nvm --version))"
  else
    fail "nvm 설치되지 않음"
  fi
fi

if command -v node &>/dev/null; then
  pass "Node.js 설치됨 ($(node --version))"
else
  fail "Node.js 설치되지 않음"
fi

if [ -d "$DOTFILES/node_modules/prettier" ]; then
  pass "Prettier 설치됨"
else
  fail "Prettier 미설치 (pnpm install 필요)"
fi

if [ -f "$DOTFILES/.git/hooks/pre-commit" ]; then
  pass "Git pre-commit hook 설정됨"
else
  fail "Git pre-commit hook 미설정"
fi

# Git

section "Git"

use_config_only=$(git config --global user.useConfigOnly 2>/dev/null)
if [ "$use_config_only" = "true" ]; then
  pass "useConfigOnly 활성화"
else
  fail "useConfigOnly 비활성화"
fi

if [ -f "$HOME/.gitconfig.local" ]; then
  pass "~/.gitconfig.local 존재"

  # includeIf gitdir trailing slash 검증
  while IFS= read -r gitdir; do
    if [[ ! "$gitdir" =~ /\"$ ]]; then
      dir="${gitdir#*\"gitdir:}"
      dir="${dir%\"*}"
      fail "includeIf gitdir에 trailing slash 누락: $dir"
    fi
  done < <(grep 'includeIf "gitdir:' "$HOME/.gitconfig.local" 2>/dev/null)
else
  fail "~/.gitconfig.local 없음"
fi

# VS Code

section "VS Code"

CODE_CMD="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

if [ -x "$CODE_CMD" ]; then
  pass "VS Code 설치됨"
  installed=$("$CODE_CMD" --list-extensions 2>/dev/null | wc -l | tr -d ' ')
  expected=$(wc -l < "$DOTFILES/vscode/extensions.txt" | tr -d ' ')
  if [ "$installed" -ge "$expected" ]; then
    pass "확장 설치됨 ($installed/$expected)"
  else
    fail "확장 누락 ($installed/$expected)"
  fi
else
  fail "VS Code 설치되지 않음"
fi

# Tailscale

section "Tailscale"

if [ -d "/Applications/Tailscale.app" ]; then
  pass "Tailscale 설치됨"
else
  fail "Tailscale 설치되지 않음"
fi

# macOS 설정

section "macOS 설정"

check_defaults com.apple.dock autohide 1 "Dock 자동 숨김"
check_defaults com.apple.dock show-recents 0 "Dock 최근 사용 앱 비활성화"

others_count=$(defaults read com.apple.dock persistent-others 2>/dev/null | grep -c "tile-data")
if [ "$others_count" -eq 0 ]; then
  pass "Dock 폴더 제거됨"
else
  fail "Dock 폴더 남아있음 (${others_count}개)"
fi

check_defaults com.apple.dock mru-spaces 0 "Spaces 자동 재정렬 비활성화"
check_defaults com.apple.finder FXPreferredViewStyle clmv "Finder 계층 보기"
check_defaults com.apple.finder FXPreferredGroupBy Application "Finder 그룹화: 응용 프로그램"
check_defaults com.apple.finder NewWindowTarget PfLo "Finder 새 창: 다운로드"
check_defaults com.apple.screencapture location "$HOME/Downloads" "스크린샷 저장: 다운로드"
check_defaults NSGlobalDomain ApplePressAndHoldEnabled 0 "키 반복 활성화"
check_defaults NSGlobalDomain com.apple.keyboard.fnState 1 "F키 표준 기능 키"
check_defaults com.apple.AppleMultitouchTrackpad Clicking 1 "트랙패드 탭하여 클릭"
check_defaults com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 1 "세 손가락 드래그 설정"

check_defaults_currenthost() {
  local domain="$1"
  local key="$2"
  local expected="$3"
  local label="$4"
  local actual
  actual=$(defaults -currentHost read "$domain" "$key" 2>/dev/null)
  if [ "$actual" = "$expected" ]; then
    pass "$label"
  else
    fail "$label (기대: $expected, 현재: $actual)"
  fi
}

check_defaults com.apple.WindowManager StandardHideWidgets 1 "데스크탑 위젯 숨김"
check_defaults com.apple.WindowManager StageManagerHideWidgets 1 "Stage Manager 위젯 숨김"

check_defaults_currenthost com.apple.controlcenter Bluetooth 18 "메뉴 막대 블루투스 항상 표시"
check_defaults_currenthost com.apple.controlcenter Sound 18 "메뉴 막대 사운드 항상 표시"

# 전원 관리

section "전원 관리"

check_pmset() {
  local key="$1"
  local expected="$2"
  local mode="$3"
  local label="$4"
  local actual
  actual=$(pmset -g custom 2>/dev/null | awk -v mode="$mode" -v key="$key" '
    $0 ~ mode {found=1} found && $1 == key {print $2; exit}
  ')
  if [ "$actual" = "$expected" ]; then
    pass "$label"
  else
    fail "$label (기대: $expected, 현재: $actual)"
  fi
}

check_pmset sleep 0 "AC Power" "시스템 잠자기 비활성화"
check_pmset displaysleep 60 "AC Power" "충전 중 화면 60분"
check_pmset displaysleep 15 "Battery Power" "배터리 화면 15분"

if is_profile "server"; then
  check_pmset womp 1 "AC Power" "Wake on LAN 활성화"

  if sudo launchctl list com.openssh.sshd &>/dev/null; then
    pass "SSH 활성화"
  else
    fail "SSH 비활성화"
  fi

  auto_update=$(sudo defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled 2>/dev/null)
  if [ "$auto_update" = "0" ]; then
    pass "자동 소프트웨어 업데이트 비활성화"
  else
    fail "자동 소프트웨어 업데이트 활성화됨"
  fi
fi

# iTerm2

section "iTerm2"

check_defaults com.googlecode.iterm2 LoadPrefsFromCustomFolder 1 "커스텀 설정 로드 활성화"
check_defaults com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES/iterm2" "설정 디렉토리: ~/dotfiles/iterm2"

# Moom Classic

section "Moom Classic"

if ! is_profile "server"; then
  if defaults read com.manytricks.Moom &>/dev/null; then
    pass "Moom Classic 설정 존재"
  else
    fail "Moom Classic 설정 없음"
  fi
fi

# 결과

echo ""
echo "=========================================="
echo -e "  ${green}✓ $pass_count 통과${reset}  ${red}✗ $fail_count 실패${reset}"
echo "=========================================="

if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
