# https://www.crondose.com/2017/02/find-potential-products-ruby/

require 'rspec'

def mod_checker1(arr, num1, num2)
  arr.select { |mod| (mod % num1).zero? && (mod % num2).zero? }
end

def mod_checker2(arr, num1, num2)
  arr.select do |mod|
     (mod % num1).zero? && (mod % num2).zero?
  end
end

describe 'Mod checker' do
  it 'returns the first value divisible by 12 and 16' do
    expect(mod_checker1(1..200, 12, 16)).to eq([48, 96, 144, 192])
    expect(mod_checker2(1..120_000, 200, 73)).to eq(
      [14_600, 29_200, 43_800, 58_400, 73_000, 87_600, 102_200, 116_800]
    )
  end
end

system 'rspec 23.rb' if __FILE__ == $PROGRAM_NAME
