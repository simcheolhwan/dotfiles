#!/bin/bash
# macOS 시스템 환경설정

source "$DOTFILES/profile.sh"

echo "⚙️  macOS 기본 설정 적용 중..."

# 기존 설정 캐시 초기화 (이전 실행의 stale 캐시 방지)
killall cfprefsd 2>/dev/null
sleep 1

# 시스템 일반

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false # 클라우드에 새 문서 저장 비활성화
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # 파일 저장 대화상자 항상 확장
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # 모든 파일 확장자 표시

# 기본 웹 브라우저

open -a "Google Chrome" --args --make-default-browser # Chrome으로 설정 (확인 대화상자 표시될 수 있음)

# 키보드

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # 맞춤법 자동 수정 비활성화
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false # 자동 대문자 비활성화
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # 스페이스 두 번으로 마침표 추가 비활성화
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # 스마트 인용 부호 비활성화
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false # 스마트 대시 비활성화
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # 키 반복 활성화
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # 키보드 네비게이션으로 컨트롤 간 포커스 이동

# 트랙패드

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true # 탭하여 클릭
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # Bluetooth 트랙패드 탭하여 클릭
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 # 현재 호스트 탭 동작 설정
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 # 전역 탭 동작 설정

defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false # 세 손가락 드래그
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0 # 세 손가락 수평 스와이프 비활성화
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0 # 세 손가락 수직 스와이프 비활성화
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true # 세 손가락 드래그 활성화
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false # Bluetooth 트랙패드 일반 드래그 비활성화
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0 # Bluetooth 트랙패드 세 손가락 수평 스와이프 비활성화
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0 # Bluetooth 트랙패드 세 손가락 수직 스와이프 비활성화
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true # Bluetooth 트랙패드 세 손가락 드래그 활성화
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerHorizSwipeGesture -int 0 # 현재 호스트 세 손가락 수평 스와이프 비활성화
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerVertSwipeGesture -int 0 # 현재 호스트 세 손가락 수직 스와이프 비활성화
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerDragGesture -bool true # 현재 호스트 세 손가락 드래그 활성화

# App Exposé

defaults write com.apple.dock showAppExposeGestureEnabled -bool true # 네 손가락 아래로 쓸어 App Exposé 활성화

# Dock

defaults write com.apple.dock autohide -bool true # 자동 숨기기
defaults write com.apple.dock autohide-delay -float 0 # 숨김 딜레이 제거
defaults write com.apple.dock tilesize -int 60 # 아이콘 크기
defaults write com.apple.dock show-recents -bool false # 최근 사용한 앱 비활성화
defaults write com.apple.dock show-suggested -bool false # 제안된 앱 비활성화
defaults write com.apple.dock persistent-apps -array # 기본 앱 아이콘 모두 제거
defaults write com.apple.dock persistent-others -array # 기본 폴더(다운로드 등) 모두 제거

add_dock_app() {
  [ -d "$1" ] || return
  defaults write com.apple.dock persistent-apps -array-add \
    "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

add_dock_app "/Applications/Google Chrome.app"
add_dock_app "/Applications/iTerm.app"
add_dock_app "/Applications/Visual Studio Code.app"
add_dock_app "/Applications/Slack.app"
add_dock_app "/Applications/Telegram.app"

# Mission Control

defaults write com.apple.dock mru-spaces -bool false # Spaces 자동 재정렬 비활성화

# Finder

defaults write com.apple.finder NewWindowTarget -string "PfLo" # 새 창 경로: 다운로드
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/" # 새 창 경로 지정
defaults write com.apple.finder FXPreferredViewStyle -string "clmv" # 계층 보기 기본값
defaults write com.apple.finder FXPreferredGroupBy -string "Application" # 그룹화: 응용 프로그램
defaults write com.apple.finder _FXSortFoldersFirst -bool true # 폴더 항상 위에
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # 확장자 변경 경고 비활성화
defaults write com.apple.finder WarnOnEmptyTrash -bool false # 휴지통 비우기 경고 비활성화

# 스크린샷

defaults write com.apple.screencapture disable-shadow -bool true # 그림자 제거
defaults write com.apple.screencapture location ~/Downloads # 저장 경로: 다운로드

# 전원 관리

sudo pmset -a sleep 0 # 시스템 잠자기 비활성화

sudo pmset -c displaysleep 60 # 충전 중: 화면 60분 후 꺼짐
sudo pmset -b displaysleep 15 # 배터리: 화면 15분 후 꺼짐

# 저장소

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # .DS_Store 네트워크 생성 방지
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true # .DS_Store USB 생성 방지
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true # Time Machine 새 디스크 제안 비활성화

# 소프트웨어 업데이트 (서버는 server.sh에서 비활성화)

if ! is_profile "server"; then
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # 매일 업데이트 확인 (최신 macOS에서 효과 제한적)
fi

# TextEdit

defaults write com.apple.TextEdit RichText -int 0 # 일반 텍스트 모드
defaults write com.apple.TextEdit ShowRuler -bool false # 눈금자 숨기기
defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool false # 입력 중 맞춤법 검사 비활성화
defaults write com.apple.TextEdit TextReplacement -bool false # 텍스트 대치 비활성화
defaults write com.apple.TextEdit SmartCopyPaste -bool false # 스마트 복사/붙여넣기 비활성화

# iTerm2

defaults write com.googlecode.iterm2 PromptOnQuit -bool false # 종료 확인 비활성화
defaults write com.googlecode.iterm2 HideActivityIndicator -bool true # 활동 표시기 숨기기
defaults write com.googlecode.iterm2 HideTabNumber -bool true # 탭 번호 숨기기
defaults write com.googlecode.iterm2 ShowNewOutputIndicator -bool false # 새 출력 표시기 비활성화
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true # 커스텀 설정 로드 활성화
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/dotfiles/iterm2" # 설정 디렉토리

# Moom Classic 설정 복원

if ! is_profile "server" && [ -f "$DOTFILES/moom/com.manytricks.Moom.plist" ]; then
  defaults import com.manytricks.Moom "$DOTFILES/moom/com.manytricks.Moom.plist"
  echo "  Moom Classic 설정 복원 완료"
fi

# 메뉴 막대
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18 # 블루투스 항상 표시
defaults -currentHost write com.apple.controlcenter Sound -int 18 # 사운드 항상 표시
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1 # Spotlight 아이콘 숨기기

# 키보드: F키를 표준 기능 키로 사용
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# 스팟라이트: 앱, 계산기, 연락처, 시스템 설정만 활성화
defaults write com.apple.Spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 1;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "DIRECTORIES";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "PDF";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 0;"name" = "TIPS";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}'

defaults write com.apple.assistant.support "Search Queries Data Sharing Status" -int 2 # Apple 검색결과 향상 기여 비활성화

# 핫코너: 모두 비활성화
defaults write com.apple.dock wvous-tl-corner -int 0 # 좌상단
defaults write com.apple.dock wvous-tl-modifier -int 0 # 좌상단 modifier
defaults write com.apple.dock wvous-tr-corner -int 0 # 우상단
defaults write com.apple.dock wvous-tr-modifier -int 0 # 우상단 modifier
defaults write com.apple.dock wvous-bl-corner -int 0 # 좌하단
defaults write com.apple.dock wvous-bl-modifier -int 0 # 좌하단 modifier
defaults write com.apple.dock wvous-br-corner -int 0 # 우하단
defaults write com.apple.dock wvous-br-modifier -int 0 # 우하단 modifier

# 배경화면: 검정 (잠금 화면도 동일하게 적용됨)

WALLPAPER="/System/Library/Desktop Pictures/Solid Colors/Black.png"
if [ -z "$SSH_CONNECTION" ] && [ -f "$WALLPAPER" ]; then
  osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER\"" 2>/dev/null
fi

# 데스크탑 위젯 비활성화 (macOS Sonoma+)

defaults write com.apple.WindowManager StandardHideWidgets -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true

# 적용

killall Dock
killall Finder
killall SystemUIServer

echo "✅ macOS 설정 적용 완료"
