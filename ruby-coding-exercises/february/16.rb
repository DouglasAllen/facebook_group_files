
# https://www.crondose.com/2017/02/build-breadcrumb-generator-ruby/
require 'rspec'

def breadcrumb_generator(arr)
  p arr.join(' / ')
end

describe 'Breadcrumb generator' do
  it 'converts an array of strings to breadcrumb' do
    items = ['String 1', 'String 2', 'String 3']
    expect(breadcrumb_generator(items)).to eq('String 1 / String 2 / String 3')
  end
end

system 'rspec 16.rb' if __FILE__ == $PROGRAM_NAME
