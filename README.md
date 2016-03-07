Dotfiles
========

install **rcm**

```sh
brew tap thoughtbot/formulae
brew install rcm
```

install this dotfiles

```sh
git clone https://github.com/Bugagazavr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
env RCRC=$HOME/.dotfiles/rcrc rcup
```
