#!/usr/bin/ruby

# Homebrew

system "sed <Brewfile 's/^/brew /' | sh"

# rcm

rcrc = File.read(File.expand_path("../rcrc", __FILE__)).chomp
excludes = rcrc.gsub(/^EXCLUDES="(.+)"$/, '\1')
rcup_opts = excludes.split(' ').map {|e| "-x #{e}"}.join(' ')

system "rcup #{rcup_opts}"

# vim backup & undo

system "mkdir -p $HOME/.vim{backup,undo}"
