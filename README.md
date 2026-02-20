# 설치 후 수동 설정

## 설치 점검

`doctor.sh`로 설치 상태를 자동 점검한다. 아래 수동 설정 전에 먼저 실행할 것.

```bash
./doctor.sh
```

- 배경화면 위젯 삭제

### 시스템 설정

- 일반 → 정보에서 컴퓨터 이름 변경
- 일반 → 공유에서 로컬 호스트 이름 변경 (영문)
- 잠금 화면에서 "화면보호기 시작되거나 화면이 꺼진 후" → "즉시" 선택
- 스팟라이트에서 "관련 컨텐츠 보기" 끄기

### Finder

- 설정(⌘,) → 사이드바에서 아래 항목만 활성화
  - 즐겨찾기: 다운로드
  - 위치: 홈, 외장 디스크, 연결된 서버

- 보기 옵션(⌘J)에서 "항상 계층 보기로 열기" 적용

  `defaults write`로 `FXPreferredViewStyle`을 설정하지만, 기존 폴더에는 `.DS_Store` 설정이 우선한다. "기본값으로 사용"을 클릭하여 전체 폴더에 적용한다.

- 보기 > 그룹 사용을 활성화하고 "응용 프로그램"으로 그루핑 확인

  `defaults write`로 `FXPreferredGroupBy`를 설정하지만, "그룹 사용" 토글은 수동 활성화가 필요하다.

## 앱

### 1Password

- 일반: 메뉴바 해제, 로그인 시 시작 해제, 단축키 제거
- 스타일: 카테고리 체크, 자주 사용 순으로 정렬
- 보안: Touch ID 또는 Mac 암호로 잠금 해제 켜기, Option 길게 누르기, 유휴 1분 후 자동 잠금

### Dropbox

- 환경설정: 온라인 전용 끄기
- 사이드바 즐겨찾기에 Dropbox 폴더 등록

### Google Chrome

- 업무 프로필 생성

### Tailscale

- Tailscale 실행 후 VPN 구성 허용 → 로그인

  첫 실행 시 "Tailscale이(가) VPN 구성을 추가하려고 합니다" 대화상자에서 허용을 클릭한다.
  이후 로그인하면 네트워크 확장 권한이 자동으로 활성화된다.

- Settings → Launch at login 켜기

### Fork

- **General**: 에디터 폰트 변경, Custom Repositories에 `~/personal`, `~/work` 폴더 추가
- **Commit**: Spell Checking 해제, Generate Commit Message with AI 활성화
- **Git**: Git Instance 경로 확인
- **Integration**: Terminal Client, External Diff/Merge Tool 설정

### Moom Classic

- [!server] Moom Classic 실행 후 접근성 권한 허용
- [!server] Launch on login 켜기

### Telegram

- General: Replace emoji automatically, Show call tab, Force touch → Reply
- Appearance: System, App icon

### Discord

- 데이터 및 개인정보: 모두 끄기

### 카카오톡

- 보안: 잠금 해제 시 Touch ID 사용 켜기
- 알림: 소리 알림 끄기
- 채팅: 사진 묶어 보내기

### VLC

- 인터페이스 어둡게

## 개발 환경

### GitHub CLI

- `gh auth login` 실행

### 저장소 클론 및 zoxide 인덱싱

- 자주 사용하는 저장소를 클론하고 zoxide에 미리 등록

### Claude Code 플러그인

- 공식 마켓플레이스 추가

  `~/.claude/plugins/`는 gitignore 대상이므로 설치 후 다시 추가해야 한다.

  ```bash
  # Claude Code 내에서 실행
  /plugin marketplace add anthropics/claude-plugins-official
  ```

- MCP 서버 설정

  플러그인별 MCP 서버 설정은 동기화되지 않으므로 수동으로 구성해야 한다.

### Firebase

- `firebase login` — Google 계정 로그인

### Git user 설정

- ~/.gitconfig.local에 includeIf로 폴더별 설정

  `useConfigOnly = true`이므로 user 설정 없이 commit하면 에러가 발생한다.
  `includeIf`를 사용하면 폴더에 따라 개인용/업무용 이메일을 자동으로 분리할 수 있다.

  ```bash
  # 1. 폴더별 gitconfig 파일 생성
  git config --file ~/.gitconfig-personal user.name "Sim Cheolhwan"
  git config --file ~/.gitconfig-personal user.email "sim@cheolhwan.com"

  git config --file ~/.gitconfig-work user.name "Sim Cheolhwan"
  git config --file ~/.gitconfig-work user.email "work@company.com"

  # 2. ~/.gitconfig.local에 includeIf 설정
  cat >> ~/.gitconfig.local << 'EOF'
  [includeIf "gitdir:~/dotfiles/"]
  	path = ~/.gitconfig-personal
  [includeIf "gitdir:~/personal/"]
  	path = ~/.gitconfig-personal
  [includeIf "gitdir:~/work/"]
  	path = ~/.gitconfig-work
  EOF
  ```

  `~/personal/` 및 `~/dotfiles/` 아래 저장소에서는 개인 이메일, `~/work/` 아래에서는 업무 이메일이 자동 적용된다.
  ⚠️ `gitdir` 경로 끝에 `/`가 없으면 매칭되지 않는다. 반드시 `gitdir:~/path/`처럼 trailing slash를 붙일 것.
  폴더를 하나만 쓴다면 `includeIf` 없이 직접 설정해도 된다:

  ```bash
  git config --file ~/.gitconfig.local user.name "Sim Cheolhwan"
  git config --file ~/.gitconfig.local user.email "sim@cheolhwan.com"
  ```

### Git 서명 키 설정

- [!server] SSH 키 생성 (기기마다 새로 생성)

  SSH 키는 기기마다 별도로 생성한다. 기기 분실 시 해당 키만 revoke하면 되고, 개인 키를 기기 간 전송할 필요가 없어 안전하다.

  ```bash
  ssh-keygen -t ed25519
  ```

- [!server] ~/.gitconfig.local에 SSH 서명 키 경로 설정

  `commit.gpgsign = true`이므로 서명 키 설정 없이 commit하면 에러가 발생한다.

  ```bash
  git config --file ~/.gitconfig.local user.signingKey ~/.ssh/id_ed25519.pub
  ```

- [!server] GitHub에 SSH 키를 Signing Key로 등록

  ```bash
  gh ssh-key add ~/.ssh/id_ed25519.pub --type signing
  ```

- [!server] 서버에 SSH 공개키 등록 및 OpenClaw 기기 페어링

  서버에 접속하여 공개키를 등록하고, OpenClaw 기기 페어링도 함께 진행한다.

- [server] 서버에서는 커밋 서명 비활성화

  서버 계정의 커밋에 개인 서명을 넣지 않으려면 비활성화한다.

  ```bash
  git config --file ~/.gitconfig.local commit.gpgsign false
  ```

### SSH 클라이언트 설정

- [!server] `~/.ssh/config` 작성

  ```
  Host *
    User <username>
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    ServerAliveInterval 30
    ServerAliveCountMax 3
    RequestTTY yes
    RemoteCommand /opt/homebrew/bin/tmux -CC new -A -s main

  Host <alias>
    HostName <hostname>
  ```

- [!server] 권한 설정

  ```bash
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/config
  ```

- [!server] SSH Multiplexing (선택)

  Tailscale 사설 네트워크에서는 지연이 이미 낮아 체감 차이가 크지 않다.

### 공개키 확인

- [!server] 서버에 등록할 공개키 확인

  ```bash
  cat ~/.ssh/id_ed25519.pub
  ```

## 서버

화면 공유로 서버에 접속하여 아래 작업을 진행한다.

### 서버에 공개 키 등록

- [server] `~/.ssh/authorized_keys`에 공개키 추가

  클라이언트에서 복사한 공개키 내용(한 줄)을 서버의 `~/.ssh/authorized_keys`에 추가한다.

  ```bash
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh

  cat >> ~/.ssh/authorized_keys <<'EOF'
  PASTE_PUBLIC_KEY_LINE_HERE
  EOF

  chmod 600 ~/.ssh/authorized_keys
  ```

### SSH

- [server] 연결 테스트

- [server] OSC 52 클립보드 검증

  SSH 세션에서 원격 클립보드가 동작하는지 확인한다. 실행 후 로컬에서 붙여넣기하여 "Hello"가 나오면 정상.

  ```bash
  printf "\033]52;c;$(printf 'Hello' | base64)\a"
  ```

### Tailscale

- [server] 관리 콘솔에서 기기 정리 및 공유 재설정

  OS 재설치 후 로그인하면 새 기기로 등록된다. 이전 기기에 걸어둔 공유 설정은 사라지므로, 관리 콘솔에서 다시 Share를 설정하고 이전 기기(오프라인)를 Remove 처리한다.

## 추가 패키지

```
brew "imagemagick"                # image
brew "ffmpeg"                     # video
brew "java"                       # firebase

cask "gcloud-cli"                 # firebase secret
cask "ngrok"                      # slack bot

# Mac App Store
mas "Final Cut Pro", id: 424389933
mas "Compressor", id: 424390742
```
