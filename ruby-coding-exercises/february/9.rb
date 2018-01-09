
# https://www.crondose.com/2017/02/customizing-ruby-sort-method-force-element-end-sorted-array/
require 'rspec'

def weird_alphabet
  ('a'..'z').sort do |l, r|
    # if l == 'k'
    #   1
    # else
    p l
    p r
    p l <=> r
    # end
  end
end

describe 'Weird Alphabet' do
  it 'creates and sorts the alphabet, but places the letter k at the end' do
    # expect(weird_alphabet.last).to eq('k')
    expect(weird_alphabet.first).to eq('a')
  end
end

system 'rspec 9.rb' if __FILE__ == $PROGRAM_NAME

# p weird_alphabet
# p weird_alphabet.first
# p weird_alphabet[10]
# p weird_alphabet.last
