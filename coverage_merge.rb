#!/usr/bin/env ruby
require 'set'

subject = ENV.fetch('COVERAGE_SUBJECT') # name of source file to summarize
subject_full = ENV.fetch('COVERAGE_SUBJECT_FULL')
data = ''
ARGV.each do |f|
  puts f
  data += File.read(f)
end
missing_lines = data.split("\n")
  .select { |l| l =~ /#{subject}/ }
  .flat_map { |l|
    # Convert each range into a set of line numbers
    l.split(' ', 5)[4].split(', ').flat_map { |range|
      first, last = range.split('-').map(&:to_i)
      last ? (first..last).to_a : [first]
    }.to_set
  }
  .reduce(&:&) # take intersection of all missed lines
  .to_a.sort

puts
code_lines = `cat #{subject_full} | grep -v -E '^(\s*#|$)' | wc -l`.split(' ').first.to_i
puts "Subject: #{ENV.fetch('COVERAGE_SUBJECT')}"
puts
puts "Coverage: #{1 - missing_lines.count.to_f / code_lines}"
puts
puts
puts missing_lines
  .reduce([]) { |a, n|
    if a.last.nil?
      a[0] = [n, nil]
    else
      if (a.last[1] && n - a.last[1] == 1) || (n - a.last[0] == 1)
        a.last[1] = n
      else
        a << [n, nil]
      end
    end
    a
  }.map { |x| x[1].nil? ? "#{x[0]}\n" : "#{x[0]}-#{x[1]}\n" }
