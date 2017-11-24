# 경로
alias study='cd ~/works/jekyll/study'

# 명령
alias ll='ls -al'
alias pretty='prettier --single-quote --no-semi --write src/{,**,**/**}/*.{js,jsx,json,css}'
alias deploy-dev='yarn build && firebase deploy --project dev'
alias deploy='REACT_APP_ENV=production yarn build && firebase deploy --project default'
alias canary='open /Applications/Google\ Chrome\ Canary.app/ --args --disable-web-security --user-data-dir'

# 애플리케이션
alias sub='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'
