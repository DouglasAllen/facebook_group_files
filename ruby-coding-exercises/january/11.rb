
# https://www.crondose.com/2017/01/coding-practice-return-odd-elements-array-ruby/
require 'rspec'
# doc
class Array
  def odd_selector
    select(&:odd?)
  end
end

describe 'Odd selector' do
  it 'given an array, it returns a collection of the odd elements' do
    expect(Array(1..10).odd_selector).to eq([1, 3, 5, 7, 9])
  end
end

system 'rspec 11.rb' if __FILE__ == $PROGRAM_NAME
