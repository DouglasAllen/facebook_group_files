
# https://www.crondose.com/2017/01/ruby-coding-exercise-accurately-calculating-large-decimals/
require 'rspec'
require 'bigdecimal'

def large_number_processor(num1, num2)
  (BigDecimal(num1) * BigDecimal(num2)).to_s('F')
end

describe 'Large number processing' do
  it 'accurately multiplies 2 large numbers' do
    val1 = '10.0987345897234093284023'
    val2 = '42.0987345897234093284023'
    expect(large_number_processor(val1, val2)).to eq(
      '425.14394718482513504388005529072886672947064529'
    )
  end
end

system 'rspec 8.rb' if __FILE__ == $PROGRAM_NAME
