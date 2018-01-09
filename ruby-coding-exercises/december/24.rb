
# https://www.crondose.com/?s=december+24
require 'rspec'

def new_max array_of_elements
  max = 0
  array_of_elements.each do |i|
    if i > max
      max = i
    end
  end
  max
end

describe 'New Max method' do
  it 'returns the max value from an array efficiently' do
    test_array = [2, 4, 10, 3, 1]
    expect(
      new_max(test_array)
      ).to eq(10)
  end
end

system 'rspec 24.rb' if __FILE__ == $PROGRAM_NAME
