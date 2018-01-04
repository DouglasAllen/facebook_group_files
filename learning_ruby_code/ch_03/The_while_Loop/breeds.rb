#!/usr/bin/env ruby

i = 0
breeds = %w[quarter arabian appalosa paint]
puts breeds.size # => 4
temp = []

while i < breeds.size
  temp << breeds[i].capitalize
  i += 1
end

temp.sort! # => ["Appalosa", "Arabian", "Paint", "Quarter"]
breeds.replace(temp)
p breeds # => ["Appalosa", "Arabian", "Paint", "Quarter"]
