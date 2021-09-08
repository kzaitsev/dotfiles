#!/usr/bin/env ruby

require 'fileutils'

PYTHON_VERSION = ENV.fetch('PYTHON_VERSION', '3.9.6')
BREW_PREFIX = /darwin/ =~ RUBY_PLATFORM ? '/usr/local/bin' : '/home/linuxbrew/.linuxbrew/bin'
OFFSET = 70

def operation(op, &block)
  if op.length < OFFSET
    print op + (' ' * (OFFSET - op.length))
  else
    print op
  end

  result = yield

  case result
  when :skipped
    print "\033[33m SKIPPED \033[0m\n"
  when :success
    print "\033[32m SUCCESS \033[0m\n"
  when :failed
    print "\033[31m FAILED \033[0m\n"
  end
end

if /darwin/ =~ RUBY_PLATFORM
  operation('Set lang:') do
    system('sudo languagesetup -langspec English 2>&1 >/dev/null')
    $? == 0 ? :success : :failed
  end
end

operation('Clone oh-my-zsh') do
  if File.exists?("#{ENV['HOME']}/.oh-my-zsh")
    :skipped
  else
    `git clone https://github.com/robbyrussell/oh-my-zsh.git #{ENV['HOME']}/.oh-my-zsh`
    $? == 0 ? :success : :failed
  end
end

%w[zshrc npmrc bundlerrc Brewfile pryrc gitignore_global gitconfig config/nvim/init.lua config/nvim/lua/statusline.lua].each do |sym|
  operation("Create symlink ~/.#{sym}:") do
    sub_path = sym.split('/')
    FileUtils.mkdir_p("#{ENV['HOME']}/.#{sub_path.take(sub_path.size - 1).join('/')}") if sub_path.size > 1

    if File.exists?("#{ENV['HOME']}/.#{sym}")
      :skipped
    else
      `ln -s #{ENV['HOME']}/.dotfiles/#{sym} #{ENV['HOME']}/.#{sym}`
      $? == 0 ? :success : :failed
    end
  end
end

operation('Run brew bundle:') do
  system("brew bundle install --global 2>&1 >/dev/null")
  :success
end

operation('Install paq-nvim:') do
  if Dir.exists?("#{ENV['HOME']}/.config/nvim/pack/paqs/start/paq-nvim")
    :skipped
  else
    system("git clone --depth=1 https://github.com/savq/paq-nvim.git #{ENV['HOME']}/.config/nvim/pack/paqs/start/paq-nvim")
    $? == 0 ? :success : :failed
  end
end

operation('Install python3:') do
  system("#{BREW_PREFIX}/pyenv install -s #{PYTHON_VERSION}")
  $? == 0 ? :success : :failed
end

operation('Set global python3:') do
  system("#{BREW_PREFIX}/pyenv global #{PYTHON_VERSION}")
  $? == 0 ? :success : :failed
end

operation('Upgrade pip for python3:') do
  system("PYENV_VERSION=#{PYTHON_VERSION} #{BREW_PREFIX}/pyenv exec pip install --upgrade -q pip")
  $? == 0 ? :success : :failed
end

operation('Install neovim for python3:') do
  system("PYENV_VERSION=#{PYTHON_VERSION} #{BREW_PREFIX}/pyenv exec pip install --upgrade -q neovim")
  $? == 0 ? :success : :failed
end

operation('Perform PlugInstall for neovim:') do
  system('nvim -c "execute \"PaqInstall\" | qa" 2>&1 >/dev/null')
  $? == 0 ? :success : :failed
end

if /darwin/ =~ RUBY_PLATFORM
  operation('Configure iTerm2 config path:') do
    system("defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string \"#{ENV['HOME']}/.dotfiles\"")
    $? == 0 ? :success : :failed
  end

  operation('Enable iTerm2 custom config path:') do
    system("defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true")
    $? == 0 ? :success : :failed
  end
end
