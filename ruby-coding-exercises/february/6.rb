
# https://www.crondose.com/2017/02/finding-elements-nested-inside-multiple-arrays-ruby/#addcomment
require 'rspec'

def find_element(collection, element)
  collection.each do |c|
    return c if c[1] == element
  end
end

def rassociate(collection, second_el)
  collection.rassoc(second_el)
end

def associate(collection, first_el)
  collection.assoc(first_el)
end

describe 'Find Element' do
  it 'returns an array from a nested array if \
  the second element equals the queried element' do
    players = [
      [27, 'Jose Altuve'],
      [2,  'Alex Bregman'],
      [1,  'Carlos Correa'],
      [9,  'Marwin Gonzalez'],
      [10, 'Yulieski Gurriel']
    ]

    expect(find_element(players, 'Jose Altuve')).to eq([27, 'Jose Altuve'])
    expect(rassociate(players, 'Marwin Gonzalez')).to eq([9, 'Marwin Gonzalez'])
    expect(associate(players, 1)).to eq([1, 'Carlos Correa'])
  end
end

system 'rspec 6.rb' if __FILE__ == $PROGRAM_NAME
