
# https://www.crondose.com/2017/01/ruby-coding-exercise-add-next-letter-number-string-sequence-ruby/
require 'rspec'

def increment_value(str)
  str + str.next.slice(-1)
end

describe 'Increment string value sequence' do
  it 'appends the next item in the sequence of a string' do
    expect(increment_value('abcde')).to eq('abcdef')
    expect(increment_value('123')).to eq('1234')
  end
end

system 'rspec 6.rb' if __FILE__ == $PROGRAM_NAME
