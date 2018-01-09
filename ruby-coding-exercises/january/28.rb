
# https://www.crondose.com/2017/01/calculate-number-days-two-days-ruby/
require 'rspec'
require 'date'

def day_counter
  Integer(Date.new(2016, 12, 25) - Date.new(2004, 7, 1))
end

describe 'Day counter' do
  it 'counts the days between Christmas in 2016 and July 1, 2004' do
    expect(day_counter).to eq(4560)
  end
end

system 'rspec 28.rb' if __FILE__ == $PROGRAM_NAME
