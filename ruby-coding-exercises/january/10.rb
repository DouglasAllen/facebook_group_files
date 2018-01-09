
# https://www.crondose.com/2017/01/ruby-coding-interview-question-build-dynamic-sum-method/

require 'rspec'

def sum_generator(num)
  (0..num).reduce(&:+)
end

describe 'Dynamic sum' do
  it 'Outputs a sum of digits, ranging from 0 through the argument value' do
    expect(sum_generator(10)).to eq(55)
  end
end

system 'rspec 10.rb' if __FILE__ == $PROGRAM_NAME
