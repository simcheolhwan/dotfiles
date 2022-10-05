alias dot="code $DOTFILES"

# 시스템
alias brew-u="brew update && brew upgrade && brew cleanup && brew doctor"

# 브라우저
export CHROME="/Applications/Google\ Chrome.app/"
export CANARY="/Applications/Google\ Chrome\ Canary.app/"
export OPTIONS="--args --disable-web-security --user-data-dir --ignore-certificate-errors"
alias chrome="open $CHROME $OPTIONS"
alias canary="open $CANARY $OPTIONS"

# 응용 프로그램
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"

# Firebase 배포
alias deploy-dev="REACT_APP_ENV=development yarn build && firebase deploy --project development"
alias deploy="REACT_APP_ENV=production yarn build && firebase deploy --project production"

# Git user
alias akaiv="git config user.name 심철환; git config user.email a@akaiv.com"
alias terra="git config user.name sim; git config user.email sim@terra.money"
alias kernel="git config user.name sim; git config user.email sim@kernellabs.co"

# PATH
export SBIN="/usr/local/sbin"
export GOBIN="~/go/bin"
export VSCODEPATH="/Applications/Visual Studio Code.app"
export VSCODEBIN=$VSCODEPATH/Contents/Resources/app/bin
export GITSCRIPTS=$DOTFILES/git/scripts
export PATH=$SBIN:$GOBIN:$VSCODEBIN:$GITSCRIPTS:$PATH
