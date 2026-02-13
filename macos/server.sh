#!/bin/bash
# 서버 전용 macOS 설정

echo "🖥️  서버 전용 설정 적용 중..."

# SSH 활성화
sudo systemsetup -setremotelogin on
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
sudo softwareupdate --schedule off
echo "  자동 소프트웨어 업데이트 비활성화 완료"

echo "✅ 서버 설정 적용 완료"
