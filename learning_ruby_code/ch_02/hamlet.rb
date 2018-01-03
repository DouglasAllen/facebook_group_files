#!/usr/bin/env ruby

hamlet = 'The slings and arrows of outrageous fortune'
p hamlet.scan(/\w+/) # => [ "The", "slings", "and", "arrows", "of", "outrageous", "fortune" ]
