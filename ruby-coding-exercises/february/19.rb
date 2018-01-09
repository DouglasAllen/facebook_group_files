# https://www.crondose.com/2017/02/calculate-nth-fibonacci-number-sequence/

def nth_fibonacci(num)
  (1..num).inject([0, 1]) do |fib|
    p fib
    fib << fib.last(2).inject(:+)
  end.last
end

require 'rspec'

describe 'nth_ibbonacci' do
  it 'properly calculates a Fibonacci value.' do
    expect(nth_fibonacci(10)).to eq(89)
  end
end

system 'rspec 19.rb' if __FILE__ == $PROGRAM_NAME


