# https://www.crondose.com/2017/02/fibonacci-sequence-generator-ruby/

require 'rspec'

def fibonacci(num)
  (1..num).inject([0, 1]) { |fib| fib << fib.last(2).inject(:+) }
end

describe 'The fibbonacci method' do
  it 'properly calculates a Fibonacci sequence' do
    expect(fibonacci(11)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144])
  end
end

system 'rspec 18.rb' if __FILE__ == $PROGRAM_NAME
