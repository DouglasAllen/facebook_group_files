
# https://www.crondose.com/2017/01/how-to-rotate-elements-array-ruby/
require 'rspec'

def array_rotation(arr, num)
  # last = arr.pop
  # na = arr.shift(num)
  # arr.unshift last
  arr.rotate(num)
end

describe 'Array index change' do
  it 'Rotates the index values for each of the array elements' do
    expect(array_rotation([1, 2, 3], 2)).to eq([3, 1, 2])
    expect(array_rotation([3, 1, 2], 2)).to eq([2, 3, 1])
    expect(array_rotation([2, 3, 1], 2)).to eq([1, 2, 3])
    expect(array_rotation([1, 2, 3, 4], 3)).to eq([4, 1, 2, 3])
  end
end

system 'rspec 16.rb' if __FILE__ == $PROGRAM_NAME
