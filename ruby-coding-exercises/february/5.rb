
# https://www.crondose.com/2017/02/build-index-based-array-hash-converter-ruby/
require 'rspec'
#
class Array
  def index_hash
    each_with_object({}) do |item, hash|
      hash[index(item)] = item
    end
  end
end

describe 'Array to Hash converter' do
  it 'converts an array to a hash, \
  with the keys being the index and the value being the element' do
    arr = %w[the quick brown fox]
    expect(arr.index_hash).to eq(0 => 'the',
                                 1 => 'quick',
                                 2 => 'brown',
                                 3 => 'fox')
  end
end

system 'rspec 5.rb' if __FILE__ == $PROGRAM_NAME
# arr = %w[the quick brown fox]
# p arr.index_hash
