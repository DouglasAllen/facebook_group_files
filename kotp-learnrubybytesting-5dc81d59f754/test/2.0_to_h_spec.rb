$LOAD_PATH << File.dirname(__FILE__)
require 'spec_helper'

Car = Struct.new(:make, :model, :year) do
  def build; end
end

ruby_version_is '2.0.0' do
  describe 'Ruby 2.0.0' do
    before :each do
      @car = Car.new('Toyota', 'Prius', 2014)
    end
    it 'Struct#to_h converts to hash' do
      @car.to_h.must_equal make: 'Toyota', model: 'Prius', year: 2014
    end
  end
end

system 'rspec 2.0_to_h_spec.rb' if __FILE__ == $PROGRAM_NAME
