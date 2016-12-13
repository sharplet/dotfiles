#!/usr/bin/env ruby

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

scripts_dir = File.expand_path("../scripts", __FILE__).chomp
system "ln -sf $HOME/bin $HOME/.scripts"
system "cd #{scripts_dir} && ./build.sh"

# vim backup & undo

system "mkdir -p $HOME/.vimbackup $HOME/.vimswap $HOME/.vimundo"
