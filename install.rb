#!/usr/bin/ruby

# Homebrew

def homebrew?
  system("which brew 2>/dev/null")
end

if homebrew?
  brew_bundle = File.expand_path("../brew-bundle", __FILE__)
  system(brew_bundle)
end

# rcm

rcrc = File.read(File.expand_path("../rcrc", __FILE__)).chomp
excludes = rcrc.gsub(/^EXCLUDES="(.+)"$/, '\1')
rcup_opts = excludes.split(' ').map {|e| "-x #{e}"}.join(' ')

system "rcup #{rcup_opts}"

# scripts

system "ln -sf $HOME/bin $HOME/.scripts"

# vim backup & undo

system "mkdir -p $HOME/.vimbackup $HOME/.vimswap $HOME/.vimundo"
