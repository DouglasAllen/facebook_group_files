
# https://www.crondose.com/2017/01/coding-interview-question-hashed-fizzbuzz-ruby/
require 'rspec'

def hashed_fizz_buzz(num)
  hash = {}
  1.upto(num).each do |e|
    if (e % 3).zero? && (e % 5).zero?
      hash[e] = 'FizzBuzz'
    elsif (e % 3).zero?
      hash[e] = 'Fizz'
    elsif (e % 5).zero?
      hash[e] = 'Buzz'
    else
      hash[e] = e
    end
  end
  hash
end

describe 'Hashed FizzBuzz' do
  it 'generates a fizz buzz hash' do
    final_hash = {
      1 => 1, 2 => 2, 3 => 'Fizz',
      4 => 4, 5 => 'Buzz',
      6 => 'Fizz',
      7 => 7, 8 => 8, 9 => 'Fizz',
      10 => 'Buzz',
      11 => 11, 12 => 'Fizz',
      13 => 13, 14 => 14, 15 => 'FizzBuzz',
      16 => 16, 17 => 17, 18 => 'Fizz',
      19 => 19, 20 => 'Buzz',
      21 => 'Fizz',
      22 => 22, 23 => 23, 24 => 'Fizz',
      25 => 'Buzz'
    }

    expect(hashed_fizz_buzz(25)).to eq(final_hash)
  end
end

system 'rspec 13.rb' if __FILE__ == $PROGRAM_NAME
