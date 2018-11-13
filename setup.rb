#!/usr/bin/env ruby

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

operation('Set lang:') do
  system('sudo languagesetup -langspec English 2>&1 >/dev/null')
  $? == 0 ? :success : :failed
end

operation('Clone oh-my-zsh') do
  if File.exists?("#{ENV['HOME']}/.oh-my-zsh")
    :skipped
  else
    `git clone https://github.com/robbyrussell/oh-my-zsh.git #{ENV['HOME']}/.oh-my-zsh`
    $? == 0 ? :success : :failed
  end
end

%w[zshrc npmrc bundlerrc Brewfile pryrc gitignore_global gitconfig config].each do |sym|
  operation("Create symlink ~/.#{sym}:") do
    if File.exists?("#{ENV['HOME']}/.#{sym}")
      :skipped
    else
      `ln -s #{ENV['HOME']}/.dotfiles/#{sym} #{ENV['HOME']}/.#{sym}`
      $? == 0 ? :success : :failed
    end
  end
end

operation('Create symlink ~/.vim:') do
  if File.exists?("#{ENV['HOME']}/.vim")
    :skipped
  else
    `ln -s #{ENV['HOME']}/.config/nvim #{ENV['HOME']}/.vim 2>&1 >/dev/null`
    $? == 0 ? :success : :failed
  end
end

operation('Create symlink ~/.vimrc:') do
  if File.exists?("#{ENV['HOME']}/.vimrc")
    :skipped
  else
    `ln -s #{ENV['HOME']}/.config/nvim/init.vim #{ENV['HOME']}/.vimrc 2>&1 >/dev/null`
    $? == 0 ? :success : :failed
  end
end

operation('Run brew bundle:') do
  system("brew bundle install --global 2>&1 >/dev/null")
  :success
end

operation('Install plug.vim:') do
  if File.exists?("#{ENV['HOME']}/.config/nvim/autoload/plug.vim")
    :skipped
  else
    system("curl -fLo #{ENV['HOME']}/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>&1 >/dev/null")
    $? == 0 ? :success : :failed
  end
end

operation('Install neovim for python2:') do
  `pip2 install --upgrade neovim 2>&1 >/dev/null`
  $? == 0 ? :success : :failed
end

operation('Install neovim for python3:') do
  `pip3 install --upgrade neovim 2>&1 >/dev/null`
  $? == 0 ? :success : :failed
end

operation('Perform PlugInstall for neovim:') do
  system('nvim -c "execute \"PlugInstall\" | qa" 2>&1 >/dev/null')
  $? == 0 ? :success : :failed
end
