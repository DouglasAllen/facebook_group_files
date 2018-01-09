
# https://www.crondose.com/2017/02/manually-removing-duplicates-array-ruby/

require 'rspec'
#
class Array
  def remove_duplicates
    each_with_object([]) do |element, arr|
      arr << element unless arr.include?(element)
    end
  end
end

describe 'Duplicate removal' do
  it 'Removed duplicates from an array' do
    arr = [1, 3, 4, 1, 4]
    expect(arr.remove_duplicates).to eq([1, 3, 4])
  end
end

system 'rspec 8.rb' if __FILE__ == $PROGRAM_NAME
