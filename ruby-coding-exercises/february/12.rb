
# https://www.crondose.com/2017/02/sum-array-string-based-integers-ruby/
require 'rspec'

def string_sum(str)
  # str.inject(0) { |a, e| a + e.to_i }
  str.map(&:to_i).inject(&:+)
end

describe 'Summing Strings' do
  it 'sums an array of string based integers' do
    expect(string_sum('1'..'20')).to eq(210)
    expect(string_sum('100'..'1000')).to eq(495_550)
  end

  it 'sums an array of integers' do
    expect(string_sum(100..1000)).to eq(495_550)
  end
end

system 'rspec 12.rb' if __FILE__ == $PROGRAM_NAME
