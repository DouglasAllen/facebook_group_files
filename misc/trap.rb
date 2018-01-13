Signal.trap("INT") do
  puts "Nope"
end
loop { sleep(1) }
