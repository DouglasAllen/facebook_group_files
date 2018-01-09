
# https://www.crondose.com/?s=december+30
require 'rspec'
# doc
class Hash
  def param_converter
    map { |i| i * '=' } * '&'
  end
end

describe 'HTML Param Converter' do
  it 'Adds an HTML param converter to the Hash class' do
    hash = { topic: 'baseball', team: 'astros' }
    expect(
      hash.param_converter
    ).to eq(
      'topic=baseball&team=astros'
    )
  end
end

system 'rspec 30.rb' if __FILE__ == $PROGRAM_NAME
