# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

@README.md

## 주요 명령어

```bash
./install.sh --profile=personal|work|server  # 새 기기 전체 설치 (프로파일 필수)
./sync.sh                                    # 현재 기기 → 저장소 역방향 동기화 (프로파일별 Brewfile, VS Code 확장 목록)
./doctor.sh                                  # 설치 상태 점검 (프로파일별)
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

## 설정 변경 시 참고

- 아래 파일은 서로 참조하므로, 한쪽을 수정하면 나머지도 함께 검토할 것

| 변경 대상              | 함께 검토                                                                  |
| ---------------------- | -------------------------------------------------------------------------- |
| `install.sh` 설치 단계 | `README.md`, `doctor.sh`                                                   |
| `macos/defaults.sh`    | `doctor.sh`                                                                |
| `profile.sh`           | `install.sh`, `brew/setup.sh`, `macos/defaults.sh`, `doctor.sh`, `sync.sh` |
| `brew/Brewfile`        | `brew/Brewfile.*` (프로파일별)                                             |
| 심볼릭 링크            | `install.sh`, `doctor.sh`, `CLAUDE.md` 매핑 테이블                         |
| 디렉토리 추가/제거     | `README.md` 구조도                                                         |

- 새 설정 파일 추가 시 `install.sh`에 심볼릭 링크 생성 코드를 함께 추가할 것
- Homebrew 패키지 추가/제거 후 `./sync.sh`로 프로파일별 Brewfile 갱신 (공통 Brewfile은 수동 관리)
- 셸 별칭은 `zsh/aliases.sh`, 함수는 `zsh/functions.sh`에 추가
- Git 별칭은 `git/.gitconfig`의 `[alias]` 섹션에 추가
- 수동 설정 항목 추가/제거 시 `MANUAL.md` 수정 (install.sh가 자동 반영, 프로파일 태그 지원)
