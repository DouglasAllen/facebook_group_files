
# https://www.crondose.com/2017/02/sort-keys-hash-ruby/
require 'rspec'

def key_sorter(collection)
  p collection.keys.map(&:to_s).sort
end

describe 'Key Sorter' do
  it 'Sorts a set of hash keys by length' do
    collection = { some_key: 'Anything',
                   'string key' => 'Anything',
                   8383 => 'Does not matter' }
    expect(key_sorter(collection)).to eq(['8383', 'some_key', 'string key'])
  end
end

system 'rspec 17.rb' if __FILE__ == $PROGRAM_NAME
