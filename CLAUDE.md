# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 저장소 개요

macOS 개발 환경 설정을 관리하는 dotfiles 저장소. 심볼릭 링크 기반으로 `~/dotfiles/`의 설정 파일들을 시스템 경로에 연결한다.

## 주요 명령어

```bash
./install.sh    # 새 기기 전체 설치 (Homebrew → 심볼릭 링크 → oh-my-zsh → nvm → VS Code → macOS 설정)
./sync.sh       # 현재 기기 → 저장소 역방향 동기화 (Brewfile, VS Code 확장 목록)
./doctor.sh     # 설치 상태 점검
```

## 심볼릭 링크 매핑

| 저장소 파일               | 시스템 경로                                                |
| ------------------------- | ---------------------------------------------------------- |
| `zsh/.zshrc`              | `~/.zshrc`                                                 |
| `git/.gitconfig`          | `~/.gitconfig`                                             |
| `git/.gitignore_global`   | `~/.gitignore_global`                                      |
| `claude/`                 | `~/.claude`                                                |
| `vscode/settings.json`    | `~/Library/Application Support/Code/User/settings.json`    |
| `vscode/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |

## 아키텍처

각 디렉토리는 독립적인 설정 영역을 담당하며, `install.sh`가 이를 조합하여 전체 환경을 구성한다.

- **zsh/**: `.zshrc`가 `aliases.sh`, `functions.sh`, `p10k.zsh`를 source. oh-my-zsh + Powerlevel10k 기반.
- **brew/**: `setup.sh`로 Homebrew 설치 후 `Brewfile`로 패키지 일괄 설치. `sync.sh`가 `brew bundle dump`로 역동기화.
- **claude/**: `~/.claude`로 심볼릭 링크되는 Claude Code 설정. agents, commands, skills, settings.json 포함.
- **vscode/**: settings.json, keybindings.json은 심볼릭 링크. extensions.txt는 `sync.sh`가 `code --list-extensions`로 갱신.
- **macos/**: `defaults write`와 `sudo pmset`으로 시스템 설정 적용 (트랙패드, Dock, Finder, 키보드, 전원 관리 등). `duti.sh`로 파일 확장자별 기본 앱 설정.
- **iterm2/**: iTerm2 설정 디렉토리 (수동으로 iTerm2에서 경로 지정 필요).

## 기기별 로컬 설정

dotfiles에 포함하지 않는 기기별 설정은 로컬 파일로 분리한다. 해당 파일이 없어도 에러 없이 무시된다.

| 로컬 파일            | 용도                     | 로드 위치                      |
| -------------------- | ------------------------ | ------------------------------ |
| `~/.zshrc.local`     | PATH, 환경변수 등        | `zsh/.zshrc` 마지막            |
| `~/.gitconfig.local` | user.name, user.email 등 | `git/.gitconfig`의 `[include]` |

## 설정 변경 시 참고

- 아래 파일은 서로 참조하므로, 한쪽을 수정하면 나머지도 함께 검토할 것

| 변경 대상              | 함께 검토                                                              |
| ---------------------- | ---------------------------------------------------------------------- |
| `install.sh` 설치 단계 | `README.md`, `doctor.sh`                                               |
| `macos/defaults.sh`    | `doctor.sh`                                                            |
| 심볼릭 링크            | `install.sh`, `doctor.sh`, `CLAUDE.md` 매핑 테이블, `README.md` 구조도 |
| 디렉토리 추가/제거     | `README.md` 구조도, `CLAUDE.md` 아키텍처                               |

- 새 설정 파일 추가 시 `install.sh`에 심볼릭 링크 생성 코드를 함께 추가할 것
- Homebrew 패키지 추가/제거 후 `./sync.sh`로 Brewfile 갱신
- 셸 별칭은 `zsh/aliases.sh`, 함수는 `zsh/functions.sh`에 추가
- Git 별칭은 `git/.gitconfig`의 `[alias]` 섹션에 추가
- 수동 설정 항목 추가/제거 시 `MANUAL.md` 수정 (install.sh가 자동 반영)
