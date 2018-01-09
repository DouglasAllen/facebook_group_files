require 'spec_helper'

describe Tippy do
  it 'has a version number' do
    expect(Tippy::VERSION).not_to be nil
  end

  it 'Accurately generates a tip given string or integer input' do
    test1 = Tippy::Builder.new(total: 100, gratuity: '23.5').generate
    test2 = Tippy::Builder.new(total: 100, gratuity: 'high').generate
    test3 = Tippy::Builder.new(total: 100, gratuity: 'LOW').generate
    test4 = Tippy::Builder.new(total: 100, gratuity: 'standard').generate
    test5 = Tippy::Builder.new(total: 100, gratuity: '18').generate
    test6 = Tippy::Builder.new(total: 100, gratuity: 20).generate
    test7 = Tippy::Builder.new(total: 100, gratuity: 0).generate

    expect(test1).to eq(123.5)
    expect(test2).to eq(125.0)
    expect(test3).to eq(115.0)
    expect(test4).to eq(118.0)
    expect(test5).to eq(118.0)
    expect(test6).to eq(120.0)
    expect(test7).to eq(100.0)
  end
end
