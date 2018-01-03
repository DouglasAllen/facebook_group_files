#!/usr/bin/env ruby

lang = :es

if lang == :en
  print 'dog'
  puts
elsif lang == :es
  print 'perro'
  puts
elsif lang == :fr
  print 'chien'
  puts
elsif lang == :de
  print 'Hund'
  puts
else
  puts "No language set; default = 'dog'."
end
