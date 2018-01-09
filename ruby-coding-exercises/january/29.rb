
# https://www.crondose.com/2017/01/implementing-null-object-pattern-ruby/
require 'rspec'
#
class NullClass
  def method_missing(name, *args, &block)
    if respond_to?(name)
      self
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    name.to_s || super
  end
end

describe 'Null class' do
  before do
    @null = NullClass.new
  end

  it 'Returns NullClass object for standard method calls \
  even when not defined' do
    expect(@null.something).to eq(@null)
  end

  it 'Returns true when asked if it responds to non existent methods' do
    expect(@null.respond_to?(:something)).to eq(true)
  end

  it 'Returns NullClass for for method calls with arguments, \
  even when not defined' do
    expect(@null.anything('hey')).to eq(@null)
  end

  it 'Returns NullClass for for method calls with a block, \
  even when not defined' do
    expect(@null.anything { 2 * 2 }).to eq(@null)
  end
end

system 'rspec 29.rb' if __FILE__ == $PROGRAM_NAME
