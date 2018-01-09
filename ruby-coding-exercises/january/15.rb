
# https://www.crondose.com/2017/01/reverse-letters-string-without-using-reverse-method-ruby/
require 'rspec'
# doc
class String
  def alt_reverse
    sl = size - 1
    rs = ''
    sl.downto(0).each do |l|
      rs << self[l]
    end
    rs
  end
end

describe 'Letter reversing' do
  it 'reverses the letters of a string without using the reverse method' do
    expect('Hi there'.alt_reverse).to eq('ereht iH')
  end
end

system 'rspec 15.rb' if __FILE__ == $PROGRAM_NAME
