
# https://www.crondose.com/2017/02/build-histogram-integer-counts-ruby/
require 'rspec'

def occurence_counter(nums)
  nums.each_with_object(Hash.new(0)) do |element, hash|
    hash[element] += 1
    p hash
  end
end

describe 'Number counter' do
  it 'returns a hash that contains the number of occurrences for \
  each array element' do
    arr = [1, 4, 1, 3, 2, 1, 4, 5, 4, 4, 5, 4]
    expect(occurence_counter(arr)).to eq(
      1 => 3,
      4 => 5,
      3 => 1,
      2 => 1,
      5 => 2
    )
  end
end

describe 'Word counter' do
  it 'returns a hash that contains the number of occurrences for \
  each array element' do
    arr = %w[how much wood could a woodchuck
             chuck if a woodchuck could chuck wood]
    expect(occurence_counter(arr)).to eq(
      'how' => 1,
      'much' => 1,
      'wood' => 2,
      'could' => 2,
      'a' => 2,
      'woodchuck' => 2,
      'chuck' => 2,
      'if' => 1
    )
  end
end

system 'rspec 13.rb' if __FILE__ == $PROGRAM_NAME
