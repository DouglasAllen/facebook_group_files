# https://www.crondose.com/2017/02/finding-largest-word-ruby-array-mixed-strings/

require 'rspec'

describe 'Word max' do
  it 'returns the longest word from an array' do
    arr = ['A sentence', 'broken into several', 'array elements']
    expect(arr.largest_word).to eq('sentence')
  end
end

system 'rspec 24.rb' if __FILE__ == $PROGRAM_NAME
