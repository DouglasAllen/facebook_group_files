
# https://www.crondose.com/2017/01/rebuild-include-method-ruby-check-array-values/
require 'rspec'

class Array
  def does_it_have?(elm)
    each do |i|
      return true if i == elm
    end
    false
  end
end

describe 'Include? clone' do
  it 'returns true if a supplied element is included in an array' do
    arr = [2, 5, 100, 4]
    expect(arr.does_it_have? 5).to eq(true)
    expect(arr.does_it_have? 20).to eq(false)
  end
end

system 'rspec 19.rb' if __FILE__ == $PROGRAM_NAME
