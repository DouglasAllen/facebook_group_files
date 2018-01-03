#!/usr/bin/env ruby

name = "Matz"
name.to_sym # => ":Matz"
:Matz.id2name # => "Matz"
p name == :Matz.id2name # => true
