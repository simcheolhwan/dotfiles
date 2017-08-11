# 설정
alias e='sub ~/.bash_profile'
alias p='sub ~/.dotfiles/.bash_profile'
alias a='sub ~/.dotfiles/.bash_aliases'
alias g='sub ~/.dotfiles/.gitconfig'
alias s='source ~/.bash_profile && echo "Done!"'
alias d='cd ~/.dotfiles && git diff HEAD'

# 경로
alias themes='cd ~/www/themes'
alias base='cd ~/www/themes/references/base'
alias study='cd ~/works/jekyll/study'

# 명령
alias ll='ls -al'
alias pretty='prettier --single-quote --no-semi --print-width 100 --write src/**/*.{js,jsx,json,css}'
alias pretty-80='prettier --single-quote --no-semi --print-width 80 --write'
alias pretty-100='prettier --single-quote --no-semi --print-width 100 --write'
alias deploy-dev='yarn build && firebase deploy --project dev'
alias deploy='REACT_APP_ENV=production yarn build && firebase deploy --project default'

# 애플리케이션
alias sub='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'
