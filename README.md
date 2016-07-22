# .dotfiles
이 파일들을 `~/.dotfiles`에 클론한 후 다음을 수행한다.

## Bash
`~/.bash_profile` 파일에 아래의 내용을 작성한다.

```sh
# Profile
if [ -f ~/.dotfiles/.bash_profile ]; then
    . ~/.dotfiles/.bash_profile
fi

# Aliases
if [ -f ~/.dotfiles/.bash_aliases ]; then
    . ~/.dotfiles/.bash_aliases
fi
```

## Git
`~/.gitconfig` 파일에 아래의 내용을 작성한다.

```config
[include]
  path = ~/.dotfiles/.gitconfig
```
