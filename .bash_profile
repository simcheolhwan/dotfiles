# Custom bash prompt
export CLICOLOR=1
export LSCOLORS=dxgxcxdxbxegedabagacad
export PS1="
\[$(tput setaf 3)\]\w\[$(tput setaf 6)\]\$(parse_git_branch)\[$(tput sgr0)\] "

# Custom PATH
export PATH=~/works/scripts:${PATH}

# Git 자동완성
source ~/.dotfiles/.git-completion.sh

# Git 브랜치 표시
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
