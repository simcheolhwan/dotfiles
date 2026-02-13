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

- 필요 시 `~/.gitconfig.local`에 사용자 정보 입력

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
