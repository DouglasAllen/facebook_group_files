
# https://www.crondose.com/2017/01/check-value-exists-set-nested-hashes-ruby/
require 'rspec'

class Array
  def value_included?(arr)
    each do |i|
      return true if i.value? arr
    end
    false
  end
end

describe 'Collection search' do
  it 'checks to see if a value is included in any number of hashes \
      nested inside an array' do
    books = [
      {
        title: 'Fountainhead',
        author: 'Ayn Rand'
      },
      {
        title: 'Deep Work',
        author: 'Cal Newport'
      }
    ]

    expect(books.value_included?('Deep Work')).to eq(true)
    expect(books.value_included?('Something Else')).to eq(false)
  end
end

system 'rspec 20.rb' if __FILE__ == $PROGRAM_NAME
