#!/usr/bin/ruby

# Homebrew

brew_bundle = File.expand_path("../brew-bundle", __FILE__)
system(brew_bundle)

# rcm

rcrc = File.read(File.expand_path("../rcrc", __FILE__)).chomp
excludes = rcrc.gsub(/^EXCLUDES="(.+)"$/, '\1')
rcup_opts = excludes.split(' ').map {|e| "-x #{e}"}.join(' ')

system "rcup #{rcup_opts}"

# vim backup & undo

system "mkdir -p $HOME/.vim{backup,undo}"
