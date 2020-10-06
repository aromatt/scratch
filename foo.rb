begin
  begin
    raise "hey"
  rescue
    puts 'inner rescue'
  ensure
    raise "ensure"
  end
rescue => e
  puts "outer rescue (#{e.message})"
end
