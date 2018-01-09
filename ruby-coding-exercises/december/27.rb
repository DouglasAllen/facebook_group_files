
# https://www.crondose.com/?s=december+27
require 'rspec'

def palindrome? word
  word.downcase == word.downcase.reverse
end

describe 'Check if a word is a palindrome' do
  it 'returns true if the word is a palindrome, false if not' do
    expect(palindrome?('tacocat')).to be(true)
    expect(palindrome?('Tacocat')).to be(true)
    expect(palindrome?('baseball')).to be(false)
  end
end

system 'rspec 27.rb' if __FILE__ == $PROGRAM_NAME
