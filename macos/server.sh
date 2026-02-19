#!/bin/bash
# 서버 전용 macOS 설정

echo "🖥️  서버 전용 설정 적용 중..."

# Dock 오른쪽에 위치 (구분을 위해)
defaults write com.apple.dock orientation -string "right"
echo "  Dock 오른쪽 위치 설정 완료"

# SSH 활성화
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist 2>/dev/null
echo "  SSH 활성화 완료"

# 화면 공유 (VNC) 활성화
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist 2>/dev/null
echo "  화면 공유 활성화 완료"

# 잠자기 완전 차단
# ⚠️ 노트북에서 실행 시 덮개를 닫아도 잠들지 않음
sudo pmset -a disablesleep 1
echo "  ⚠️  잠자기 방지 활성화 (disablesleep 1)"

# Wake on LAN (네트워크 매직 패킷으로 깨우기)
sudo pmset -a womp 1
echo "  Wake on LAN 활성화"

# 자동 소프트웨어 업데이트 비활성화
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool false
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
echo "  자동 소프트웨어 업데이트 비활성화 완료"

# tmux 클립보드 공유 (SSH 원격 복사 지원)
grep -qxF 'set -s set-clipboard on' "$HOME/.tmux.conf" 2>/dev/null || echo 'set -s set-clipboard on' >> "$HOME/.tmux.conf"
echo "  tmux 클립보드 설정 완료"

# Dock 재시작 (orientation 변경 반영)
killall Dock

echo "✅ 서버 설정 적용 완료"
