# https://www.crondose.com/2017/02/using-rubys-detect-method-find-divisible-numbers/

require 'rspec'

def mod_checker(arr, num1, num2)
  arr.detect do |mod|
    p mod
    mod % num1.zero? && mod % num2.zero?
  end
end

describe 'Mod checker' do
  it 'returns the first value divisible by 12 and 16' do
    expect(mod_checker(1..200, 12, 16)).to eq(48)
    expect(mod_checker(1..120_000, 200, 73)).to eq(14_600)
  end
end

system 'rspec 21.rb' if __FILE__ == $PROGRAM_NAME
