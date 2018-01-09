
# https://www.crondose.com/2017/01/ruby-coding-practice-build-fraction-calculator/
require 'rspec'

def convert_rational(num1, num2, _opperator)
  Rational(num1)
  Rational(num2)
end

def fraction_calculator(fraction_one, fraction_two, operator)
  num1 = Rational(fraction_one)
  num2 = Rational(fraction_two)
  result = case operator
           when '*' then num1 * num2
           when '/' then num1 / num2
           when '+' then num1 + num2
           when '-' then num1 - num2
           end
  result.to_s
end

describe 'Fraction multiplication' do
  it 'can multiply two string fractions and output string based fraction' do
    expect(fraction_calculator('1/3', '2/4', '*')).to eq('1/6')
    expect(fraction_calculator('1/3', '2/4', '/')).to eq('2/3')
    expect(fraction_calculator('1/3', '2/4', '+')).to eq('5/6')
    expect(fraction_calculator('1/3', '2/4', '-')).to eq('-1/6')
  end
end

system 'rspec 9.rb' if __FILE__ == $PROGRAM_NAME

print fraction_calculator('1/9', '1/8', '/')
