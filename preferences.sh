defaults write com.apple.screencapture disable-shadow -bool true # 스크린샷 그림자 제거
defaults write com.apple.screencapture location ~/Downloads # 스크린샷 경로 변경
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # 파일 저장 상자를 언제나 확장 상태로 열기
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false # 클라우드에 새 문서 저장 (비활성화)
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # .DS_Store 파일을 네트워크에서 생성하지 않기
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true # .DS_Store 파일을 USB에서 생성하지 않기
defaults write com.apple.dock persistent-apps -array # Dock에서 모든 앱 아이콘 제거
defaults write com.apple.dock tilesize -int 60 # Dock 아이콘 크기 설정
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # App Store 자동 업데이트 확인 (매일)

# Dock
defaults write com.apple.dock autohide -bool true # 자동으로 Dock 가리기와 보기
defaults write com.apple.dock show-recents -bool false # Dock에서 최근 사용한 응용 프로그램 보기 (비활성화)

# Mission Control
defaults write com.apple.dock mru-spaces -bool false # Spaces를 최근 사용 내역에 따라 자동으로 재정렬 (비활성화)

# 보안 및 개인 정보 보호
defaults write com.apple.screensaver askForPassword -int 1 # 화면보호기 비밀번호 묻기
defaults write com.apple.screensaver askForPasswordDelay -int 0 # 화면보호기 비밀번호 즉시 묻기

# 키보드 > 텍스트
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # 맞춤법 자동 수정 (비활성화)
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false # 자동으로 대문자로 시작 (비활성화)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # 스페이스를 두 번 눌러 마침표 추가 (비활성화)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # 스마트 인용 부호 및 대시 사용 (비활성화)
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false # 스마트 인용 부호 및 대시 사용 (비활성화)

# 키보드 > 단축키
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # 키보드 네비게이션을 사용하여 컨트롤 간 포커스 이동

# 트랙패드 > 포인트와 클릭 > 탭하여 클릭하기
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# 손쉬운 사용 > 포인터 제어기 > 트랙패드 옵션... > 드래그 활성화 > 세 손가락으로 드래그하기
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerVertSwipeGesture -int 0
defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerDragGesture -bool true

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # 모든 파일 확장자 보기
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # 확장자를 변경하기 전에 경고 보기 (비활성화)
defaults write com.apple.finder WarnOnEmptyTrash -bool false # 휴지통을 비우기 전에 경고 표시 (비활성화)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv" # 항상 계층 보기로 열기

# TextEdit
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit ShowRuler -bool false
defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool false
defaults write com.apple.TextEdit TextReplacement -bool false
defaults write com.apple.TextEdit SmartCopyPaste -bool false

# iTerm2
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 HideActivityIndicator -bool true
defaults write com.googlecode.iterm2 HideTabNumber -bool true
defaults write com.googlecode.iterm2 ShowNewOutputIndicator -bool false
