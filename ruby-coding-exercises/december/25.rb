
# https://www.crondose.com/?s=december+25
require 'rspec'

unchangeable_elements = [1, 2, 3].freeze

describe 'Immutable array' do
  it 'does not allow an array to be altered' do
    expect do
      unchangeable_elements << 4
    end.to raise_error(
      RuntimeError
    )
  end
end

system 'rspec 25.rb' if __FILE__ == $PROGRAM_NAME
