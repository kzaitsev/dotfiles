PYTHON_VERSION ?= "3.10.4"

mac: mac_system_setup zsh symlinks brewfile python nvim

zsh:
	if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh; fi
	${HOME}/.oh-my-zsh/tools/upgrade.sh

mac_system_setup:
	osascript -e 'tell application "System Preferences" to quit'

	# Locale
	defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
	defaults write NSGlobalDomain AppleLocale -string "en_US"
	defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
	defaults write NSGlobalDomain AppleMetricUnits -bool true

	# Finder
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
	defaults write com.apple.finder _FXSortFoldersFirst -bool true
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder ShowStatusBar -bool true

	# Screenshots
	defaults write com.apple.screencapture type -string "png"
	defaults write com.apple.screencapture disable-shadow -bool true

	# Subpixel font rendering
	defaults write NSGlobalDomain AppleFontSmoothing -int 1

	# iTerm2
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.dotfiles/"
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

symlinks:
	ln -sf ${HOME}/.dotfiles/zshrc ${HOME}/.zshrc
	ln -sf ${HOME}/.dotfiles/npmrc ${HOME}/.npmrc
	ln -sf ${HOME}/.dotfiles/bundlerrc ${HOME}/.bundlerrc
	ln -sf ${HOME}/.dotfiles/Brewfile ${HOME}/.Brewfile
	ln -sf ${HOME}/.dotfiles/pryrc ${HOME}/.pryrc
	ln -sf ${HOME}/.dotfiles/gitignore_global ${HOME}/.gitignore_global
	ln -sf ${HOME}/.dotfiles/gitconfig ${HOME}/.gitconfig
	mkdir -p ${HOME}/.config/nvim
	mkdir -p ${HOME}/.config/nvim/lua
	ln -sf ${HOME}/.dotfiles/config/nvim/init.lua ${HOME}/.config/nvim/init.lua
	ln -sf ${HOME}/.dotfiles/config/nvim/lua/statusline.lua ${HOME}/.config/nvim/lua/statusline.lua

.PHONY: brewfile
brewfile:
	brew bundle install --global 2>&1 >/dev/null

python:
	$$(brew --prefix)/bin/pyenv install -s ${PYTHON_VERSION}
	$$(brew --prefix)/bin/pyenv global ${PYTHON_VERSION}
	PYENV_VERSION=${PYTHON_VERSION} $$(brew --prefix)/bin/pyenv exec pip install --upgrade -q pip

nvim:
	mkdir -p ${HOME}/.config/nvim/pack/packer/start/
	if [[ ! -d "${HOME}/.config/nvim/pack/packer/start/packer.nvim" ]]; then git clone --depth 1 https://github.com/wbthomason/packer.nvim ${HOME}/.config/nvim/pack/packer/start/packer.nvim; fi

	nvim -c "execute \"PackerInstall\" | qa" 2>&1 >/dev/null

