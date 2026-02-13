# dotfiles

macOS 개발 환경 설정을 관리하는 저장소. Homebrew 패키지, zsh, Git, VS Code, macOS 시스템 설정 등을 포함한다.

## 저장소 구조

```
~/dotfiles/
├── install.sh              # 전체 설치 스크립트
├── sync.sh                 # 역방향 동기화 스크립트
├── doctor.sh               # 설치 점검 스크립트
├── macos/
│   ├── defaults.sh         # macOS 시스템 설정
│   └── duti.sh             # 파일 확장자별 기본 앱 설정
├── zsh/
│   ├── .zshrc              # zsh 설정 (oh-my-zsh + Powerlevel10k)
│   ├── aliases.sh          # 별칭
│   ├── functions.sh        # 함수
│   └── p10k.zsh            # Powerlevel10k 설정
├── git/
│   ├── .gitconfig          # Git 설정
│   └── .gitignore_global   # Git 전역 무시 규칙
├── brew/
│   ├── Brewfile            # Homebrew 패키지 목록
│   └── setup.sh            # Homebrew 설치 스크립트
├── vscode/
│   ├── settings.json       # VS Code 설정
│   ├── keybindings.json    # VS Code 키바인딩
│   └── extensions.txt      # VS Code 확장 목록
├── iterm2/                 # iTerm2 설정 디렉토리
├── claude/                 # Claude Code 설정 (~/.claude로 연결)
├── .prettierrc             # Prettier 설정
├── .prettierignore         # Prettier 무시 규칙
└── package.json            # 개발 도구 (prettier, lint-staged, simple-git-hooks)
```

| 디렉토리  | 설명                                         |
| --------- | -------------------------------------------- |
| `macos/`  | 트랙패드, Dock, Finder 등 macOS 시스템 설정  |
| `zsh/`    | oh-my-zsh 기반 셸 설정, 별칭, 함수           |
| `git/`    | Git 전역 설정                                |
| `brew/`   | Homebrew 패키지 관리                         |
| `vscode/` | VS Code 설정 및 확장                         |
| `iterm2/` | iTerm2 설정 백업                             |
| `claude/` | Claude Code 설정 (`~/.claude`로 심볼릭 링크) |

## 전제조건

- Apple Silicon Mac (M1 이상)

## 새 기기 설정 방법

```bash
git clone https://github.com/simcheolhwan/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh sync.sh
./install.sh
```

`install.sh`가 수행하는 작업:

1. Homebrew 설치 및 패키지 설치
2. 심볼릭 링크 생성 (`.zshrc`, `.gitconfig`, VS Code 설정 등)
3. oh-my-zsh 설치
4. Powerlevel10k 테마 설치
5. zsh 플러그인 설치 (`zsh-autosuggestions`, `zsh-syntax-highlighting`)
6. nvm 및 최신 LTS Node.js 설치 + Git hooks 설정 (Prettier 자동 포맷팅)
7. VS Code 확장 설치
8. macOS 시스템 설정 적용
9. 파일 연결 설정 (duti로 기본 앱 지정)

## 현재 기기 → 저장소 동기화

```bash
cd ~/dotfiles
./sync.sh
git add --all
```

`sync.sh`는 현재 설치된 Homebrew 패키지와 VS Code 확장 목록을 저장소에 반영한다.

## 기기별 로컬 설정

dotfiles에 포함하지 않는 기기별 설정은 아래 파일에 작성한다. 파일이 없으면 무시된다.

- `~/.zshrc.local` — PATH, 환경변수 등
- `~/.gitconfig.local` — Git user 설정 등

```bash
# 예: 기기별 PATH 추가
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc.local

# 예: 기기별 Git user 설정
git config --file ~/.gitconfig.local user.name "이름"
git config --file ~/.gitconfig.local user.email "email@example.com"
```

## 설치 후 수동 설정

`install.sh` 완료 후 수동으로 진행해야 할 항목은 [`MANUAL.md`](MANUAL.md)를 참고한다.

## 설치 점검

`doctor.sh`로 자동 점검하고, 수동 항목은 [`MANUAL.md`](MANUAL.md)를 참고한다.

```bash
./doctor.sh
```
