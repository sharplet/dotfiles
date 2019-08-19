#!/usr/bin/env ruby

# rcm

rcrc = File.read(File.expand_path("../rcrc", __FILE__)).chomp
excludes = rcrc.gsub(/^EXCLUDES="(.+)"$/, '\1')
rcup_opts = excludes.split(' ').map {|e| "-x #{e}"}.join(' ')

system "rcup #{rcup_opts}"

# scripts

scripts_dir = File.expand_path("../scripts", __FILE__).chomp
system "ln -sf $HOME/bin $HOME/.scripts"
system "./build.sh"

# vim backup & undo

system "mkdir -p $HOME/.vimbackup $HOME/.vimswap $HOME/.vimundo"
