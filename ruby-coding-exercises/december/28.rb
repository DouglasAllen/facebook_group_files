
# https://www.crondose.com/?s=december+28
require 'rspec'

def array_converter(*arrays)
  arrays.flatten.map(&:to_i)
end

describe 'Combine arrays and convert strings to integers' do
  it 'can take in a variable number of arrays and return a single array' do
    arr1 = %w(1 5 9)
    arr2 = %w(10 2 7 10)
    arr3 = %w(3 4 0)
    expect(
      array_converter(arr1, arr2, arr3).count
    ).to eq(10)
    expect(
      array_converter(arr1).first
    ).to eq(1)
  end
end

system 'rspec 28.rb' if __FILE__ == $PROGRAM_NAME
