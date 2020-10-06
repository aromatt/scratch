#!/usr/bin/env ruby

path = ARGV[0]

`mkfifo #{path}` unless File.exists?(path)

input = open(path, "r")

IO.foreach(path) { |line|
  puts line
}
