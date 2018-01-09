
# https://www.crondose.com/?s=december+21
require 'rspec'

def sentence_reverser(str)
  str.split.reverse.join(' ')
end

describe 'Sentence reverser' do
  it 'reverses the words in a sentence' do
    test_sentence = 'backwards am I'
    expect(
      sentence_reverser(test_sentence)
    ).to eq(
      'I am backwards'
    )
  end
end

system 'rspec 24.rb' if __FILE__ == $PROGRAM_NAME
