#!/usr/bin/env ruby

class Foo
  def self.route(&block)
    @@b = block
  end
  def run!(*args)
    @@b.call *args
  end
end

Foo.route do |a|
  puts "route #{a}"
end

Foo.new.run! 1
