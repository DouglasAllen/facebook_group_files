# https://www.crondose.com/2017/02/find-largest-words-array-ruby/

require 'rspec'

def largest_words(strings, num)
  strings.max_by(num, &:length)
end

describe 'Largest words' do
  it 'returns the largest words from an array' do
    strings = %w[a group of words that are variable length]
    expect(largest_words(strings, 3)).to eq(%w[variable length words])
  end
end

system 'rspec 22.rb' if __FILE__ == $PROGRAM_NAME
