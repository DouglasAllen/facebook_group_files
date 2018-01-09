
# https://www.crondose.com/2017/01/create-range-months-using-ruby-date-library/
require 'rspec'
require 'date'

def his
  ((Date.new(2017, 1))..(Date.new(2017, 12))).each_with_object([]) do |date, month_array|
    month_array << date.strftime('%B')
  end.uniq
end

def months
  Date::MONTHNAMES[1..12]
end

describe 'Month generator' do
  it 'returns the full list of months for a year as an array' do
    expect(his).to eq(
      %w[January February March April
         May June July August
         September October November December]
    )
  end
end

system 'rspec 31.rb' if __FILE__ == $PROGRAM_NAME
