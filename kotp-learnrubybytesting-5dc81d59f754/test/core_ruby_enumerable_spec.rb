$LOAD_PATH << File.dirname(__FILE__)
require 'spec_helper'

describe Enumerable do
  it 'must inject or reduce collections' do
    my_collection = (5..10)
    # 45.must_equal(my_collection.inject(:+))
    # 45.must_equal(my_collection.inject(0, :+))
    # 46.must_equal my_collection.inject(1, :+)
    # 10.must_equal(my_collection.inject { |memo, number| number > memo ? number : memo }
    # ).must_equal(10)
  end
end

system 'rspec core_ruby_enumerable_spec.rb' if __FILE__ == $PROGRAM_NAME
