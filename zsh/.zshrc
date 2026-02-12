# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh 경로
export ZSH="$HOME/.oh-my-zsh"

# 테마
ZSH_THEME="powerlevel10k/powerlevel10k"

# 플러그인
plugins=(
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# 에디터
export EDITOR="code --wait"

# dotfiles 경로
export DOTFILES="$HOME/dotfiles"

# 별칭
source "$DOTFILES/zsh/aliases.sh"
source "$DOTFILES/zsh/functions.sh"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Powerlevel10k 설정
[[ ! -f "$DOTFILES/zsh/p10k.zsh" ]] || source "$DOTFILES/zsh/p10k.zsh"

# 기기별 로컬 설정 (dotfiles에 포함하지 않는 PATH, 환경변수 등)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
