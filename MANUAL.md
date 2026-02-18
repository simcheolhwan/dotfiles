# 설치 후 수동 설정

## macOS

### defaults 재적용 (필수)

첫 설치 후 재시작하면 macOS 초기화가 Dock 등 일부 설정을 덮어쓴다. 재시작 후 반드시 한 번 더 실행할 것:

```bash
source ~/dotfiles/macos/defaults.sh
```

### 시스템 설정

- 일반 → 정보에서 컴퓨터 이름 변경
- 일반 → 공유에서 로컬 호스트 이름 변경 (영문)
- 잠금 화면에서 "화면보호기 시작되거나 화면이 꺼진 후" → "즉시" 선택
- 스팟라이트에서 "관련 컨텐츠 보기" 끄기

### Finder

- 설정(⌘,) → 사이드바에서 다운로드·홈·외장 디스크만 활성화

- 보기 옵션(⌘J)에서 "항상 계층 보기로 열기" 적용

  `defaults write`로 `FXPreferredViewStyle`을 설정하지만, 기존 폴더에는 `.DS_Store` 설정이 우선한다. "기본값으로 사용"을 클릭하여 전체 폴더에 적용한다.

- 보기 > 그룹 사용을 활성화하고 "응용 프로그램"으로 그루핑 확인

  `defaults write`로 `FXPreferredGroupBy`를 설정하지만, "그룹 사용" 토글은 수동 활성화가 필요하다.

## 앱

### Tailscale

- Tailscale 실행 후 VPN 구성 허용 → 로그인

  첫 실행 시 "Tailscale이(가) VPN 구성을 추가하려고 합니다" 대화상자에서 허용을 클릭한다.
  이후 로그인하면 네트워크 확장 권한이 자동으로 활성화된다.

- Settings → Launch at login 켜기

### Fork

- **General**: 에디터 폰트 변경, 자동으로 업데이트를 다운로드 하기 활성화
- **General**: Custom Repositories에 `~/personal`, `~/work` 폴더 추가
- **Commit**: Spell Checking 해제, Generate Commit Message with AI 활성화
- **Git**: Git Instance 경로 확인
- **Integration**: Terminal Client, External Diff/Merge Tool 설정

### Moom Classic

- [!server] Moom Classic 실행 후 접근성 권한 허용

## 개발 환경

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
  ssh-keygen -t ed25519 -C "sim@cheolhwan.com"
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

- [server] 서버에서는 커밋 서명 비활성화

  서버 계정의 커밋에 개인 서명을 넣지 않으려면 비활성화한다.

  ```bash
  git config --file ~/.gitconfig.local commit.gpgsign false
  ```

### GitHub CLI

- `gh auth login` 실행

### Claude Code 플러그인

- 공식 마켓플레이스 추가

  `~/.claude/plugins/`는 gitignore 대상이므로 설치 후 다시 추가해야 한다.

  ```bash
  # Claude Code 내에서 실행
  /plugin marketplace add anthropics/claude-plugins-official
  ```

- MCP 서버 설정

  플러그인별 MCP 서버 설정은 동기화되지 않으므로 수동으로 구성해야 한다.

## 서버

### SSH

- [server] 연결 테스트

### Tailscale

- [server] 관리 콘솔에서 기기 정리 및 공유 재설정

  OS 재설치 후 로그인하면 새 기기로 등록된다. 이전 기기에 걸어둔 공유 설정은 사라지므로, 관리 콘솔에서 다시 Share를 설정하고 이전 기기(오프라인)를 Remove 처리한다.

### 화면 공유

- [server] VNC 연결 테스트
