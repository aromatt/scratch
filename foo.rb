if true
  begin
    lkjasdf
  rescue
  end
end
exit

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

puts "\n\n\n==="
begin
  `ls lakjsdfasdfasdfasdf`
  puts $?.inspect
  puts "Nothing rescued"
rescue => e
  puts "rescued #{e.message}"
  puts e.inspect
end


