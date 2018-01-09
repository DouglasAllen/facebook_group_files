
# https://www.crondose.com/2017/01/generating-hash-two-arrays-ruby/
require 'rspec'

def title_builder(headers, data)
  hash = {}

  headers.each_with_index do |header, index|
    hash[header] = data[index]
  end

  hash
end

describe 'Hash builder' do
  it 'combines two arrays to generate a hash' do
    arr1 = %w[title description rating]
    arr2 = ['Fountainhead', 'Novel about unique perspectives', 5]
    expect(
      title_builder(arr1, arr2)
    ).to eq(
      'title' => 'Fountainhead',
      'description' => 'Novel about unique perspectives',
      'rating' => 5
    )
  end
end

system 'rspec 17.rb' if __FILE__ == $PROGRAM_NAME
