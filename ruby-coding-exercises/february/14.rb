
# https://www.crondose.com/2017/02/remove-vowels-array-ruby/
require 'rspec'

def vowel_remover(alpha)
  p alpha.grep(/[^aeiou]/)
end

describe 'Vowel remover' do
  it 'removes vowels from the alphabet' do
    alphabet = ('a'..'z')
    expect(
      vowel_remover(alphabet)
    ).to eq(
      %w[b c d f g h j k l m n p q r s t v w x y z]
    )
  end
end

system 'rspec 14.rb' if __FILE__ == $PROGRAM_NAME
