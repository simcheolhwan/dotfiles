# 단축 명령어
alias dot="code $DOTFILES"
alias bu="brew upgrade --greedy && brew cleanup && brew doctor"
alias pnpm-reset='find . -type d -name "node_modules" -prune -exec rm -rf '{}' + && rm -rf pnpm-lock.yaml && pnpm store prune && pnpm install --no-frozen-lockfile'

# Claude Code
alias opus="claude --model opus\[1m\]"
alias sonnet="claude --model sonnet"
alias haiku="claude --model haiku"
