#!/usr/bin/env ruby

path = ARGV[0]

`mkfifo #{path}` unless File.exists?(path)

output = open(path, 'w+') # the w+ means we don't block
c = 0
while true
  data = Time.now.utc
  puts data
  output.puts data
  sleep 1
  output.flush
end
#output.close

puts "Sent data to pipe #{path}"
