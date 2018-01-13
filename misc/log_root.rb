#!/usr/local/env ruby

a = 25

puts Math.sqrt(a)

puts 10**(Math.log10(a) / 2)

def sqrt(x)
  10**(Math.log10(x) / 2)
end

puts sqrt(a)

def sqrt1(x)
  10**Math.log10(x) / 2 # what is the precedence of operators?
end

puts sqrt1(a)
puts 10**Math.log10(a)

# Calculating square roots by Newton's method, inspired by SICP
#   http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1.7

def sqrt2(x)
  @x = x
  def average(a, b)
    (a + b) / 2.0
  end

  def is_good_enough(guess)
    ((guess * guess) - @x).abs < 0.0000000001
  end

  def improve(guess)
    average(guess, @x / guess)
  end

  def sqrt_iter(guess)
    if is_good_enough(guess)
      guess
    else
      sqrt_iter(improve(guess))
    end
  end

  sqrt_iter(1.0)
end

puts sqrt2(9)
