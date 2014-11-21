#!/usr/bin/ruby

system "sed <Brewfile 's/^/brew /' | sh"

rcrc = File.read(File.expand_path("../rcrc", __FILE__)).chomp
excludes = rcrc.gsub(/^EXCLUDES="(.+)"$/, '\1')
rcup_opts = excludes.split(' ').map {|e| "-x #{e}"}.join(' ')

system "rcup #{rcup_opts}"
