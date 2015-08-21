#!/usr/bin/env ruby
#
# Written by Vlas Veloshin: https://melbournecocoa.slack.com/files/vlas/F07Q8NXNC/delete-duplicate-sims.rb

class SimDevice
  
  attr_accessor :runtime
  attr_accessor :name
  attr_accessor :identifier
  
  def initialize(runtime, name, identifier)
    @runtime = runtime
    @name = name
    @identifier = identifier
  end
  
  def to_s
    return "#{@name} - #{@runtime} (#{identifier})"
  end
  
  def equivalent_to_device(device)
    return @runtime == device.runtime && @name == device.name
  end
  
end

def execute_simctl_command(command)
  return %x[xcrun simctl #{command}]
end

def delete_device(device)
  execute_simctl_command("delete #{device.identifier}")
end

devices = []
runtime = ""
execute_simctl_command("list devices").lines.each do |line|
  case line[0]
  when '='
    # First header, skip it
  when '-'
    # Runtime header
    runtime = line.scan(/-- (.+?) --/).flatten[0]
  else
    name_and_identifier = line.scan(/\s+(.+?) \(([^\)]+)/)[0]
    device = SimDevice.new(runtime, name_and_identifier[0], name_and_identifier[1])
    devices.push(device)
  end
end

duplicates = {}
# Enumerate all devices except for the last one
for i in 0..devices.count-2
  device = devices[i]
  # Enumerate all devices *after* this one
  for j in i+1..devices.count-1
    potential_duplicate = devices[j]
    if potential_duplicate.equivalent_to_device(device)
      duplicates[potential_duplicate] = device
      break
    end
  end
end

if duplicates.count == 0
  puts(" 🎉  You don't have duplicate simulators!")
  exit()
end

puts(" ⚠️  Looks like you have #{duplicates.count} duplicate simulator#{duplicates.count > 1 ? "s" : ""}:")
duplicates.each_pair do |duplicate, original|
  puts("#{duplicate} -- duplicate of #{original}")
end

puts(" ⚠️  Note that the deleted duplicate may be the older one of two, with some apps on it!")
puts(" ⚠️  Would you like to delete them? (y/n and return)")
answer = gets.strip
if (answer != "y" && answer != "yes")
  puts(" 🚫  Aborting.")
  exit()
end

puts(" 💬  Deleting...")
duplicates.each_key do |duplicate|
  delete_device(duplicate)
end

puts(" ✅  Done!")
