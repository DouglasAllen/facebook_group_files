#!/usr/bin/env ruby
#
class Hello
  def initialize(hello)
    @hello = hello
  end

  attr_reader :hello
end

salute = Hello.new('Hello, Matz!')
puts salute.hello
