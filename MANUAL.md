# 설치 후 수동 설정

## macOS

- 시스템 설정 → 일반 → 정보에서 컴퓨터 이름 변경

- 시스템 설정 → 일반 → 공유에서 로컬 호스트 이름 변경 (영문)

- 시스템 설정 → 손쉬운 사용 → 포인터 제어에서 세 손가락 드래그 확인

  `defaults write`로 설정하지만, macOS 버전에 따라 직접 활성화해야 할 수 있다. 포인터 제어 → 트랙패드 옵션 → "드래그 활성화"를 "세 손가락으로 드래그"로 설정한다.

- Finder → 설정(⌘,) → 사이드바에서 다운로드·홈·외장 디스크만 활성화

- Finder → 보기 옵션(⌘J)에서 "항상 계층 보기로 열기" 적용

  `defaults write`로 `FXPreferredViewStyle`을 설정하지만, 기존 폴더에는 `.DS_Store` 설정이 우선한다. "기본값으로 사용"을 클릭하여 전체 폴더에 적용한다.

## 터미널

- 터미널을 재시작하거나 `source ~/.zshrc` 실행

- Powerlevel10k 프롬프트가 정상 표시되는지 확인

- 셸 플러그인 동작 확인 (자동완성 제안, 구문 강조)

- iTerm2에서 설정 디렉토리를 `~/dotfiles/iterm2/`로 지정
  1. Settings → General → Preferences
  2. "Load preferences from a custom folder or URL" 체크
  3. 경로를 `~/dotfiles/iterm2`로 지정
  4. "Save changes"를 "Automatically"로 설정

## 앱

- Moom Classic 환경설정

  키보드 단축키, 스냅 영역 등 창 관리 설정을 구성한다.

- Fork → Settings에서 환경설정
  - **General**: 에디터 폰트 변경
  - **Commit**: Spell Checking 해제, Generate Commit Message with AI 활성화
  - **Git**: Git Instance 경로 확인
  - **Integration**: Terminal Client, External Diff/Merge Tool 설정

## 개발 환경

- ~/.gitconfig.local에 includeIf로 폴더별 Git user 설정

  `useConfigOnly = true`이므로 user 설정 없이 commit하면 에러가 발생한다.
  `includeIf`를 사용하면 폴더에 따라 개인용/업무용 이메일을 자동으로 분리할 수 있다.

  ```bash
  # 1. 폴더별 gitconfig 파일 생성
  git config --file ~/.gitconfig-personal user.name "이름"
  git config --file ~/.gitconfig-personal user.email "personal@example.com"

  git config --file ~/.gitconfig-work user.name "이름"
  git config --file ~/.gitconfig-work user.email "work@company.com"

  # 2. ~/.gitconfig.local에 includeIf 설정
  cat >> ~/.gitconfig.local << 'EOF'
  [includeIf "gitdir:~/personal/"]
  	path = ~/.gitconfig-personal
  [includeIf "gitdir:~/work/"]
  	path = ~/.gitconfig-work
  EOF
  ```

  `~/personal/` 아래 저장소에서는 개인 이메일, `~/work/` 아래에서는 업무 이메일이 자동 적용된다.
  ⚠️ `gitdir` 경로 끝에 `/`가 없으면 매칭되지 않는다. 반드시 `gitdir:~/path/`처럼 trailing slash를 붙일 것.
  폴더를 하나만 쓴다면 `includeIf` 없이 직접 설정해도 된다:

  ```bash
  git config --file ~/.gitconfig.local user.name "이름"
  git config --file ~/.gitconfig.local user.email "email@example.com"
  ```

- Claude Code에서 공식 마켓플레이스 추가

  `~/.claude/plugins/`는 gitignore 대상이므로 설치 후 다시 추가해야 한다.

  ```bash
  # Claude Code 내에서 실행
  /plugin marketplace add anthropics/claude-plugins-official
  ```

## 서버

- [server] SSH 연결 테스트

- [server] 화면 공유 (VNC) 연결 테스트
