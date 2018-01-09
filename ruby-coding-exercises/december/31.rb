
# https://www.crondose.com/?s=currency+converter+december+31
require 'rspec'

# ¥
# £
# $

def currency_converter(amount, location)
  case location
  when 'US' then format('$%.2f', amount)
  when 'Japan' then format('¥%.0f', amount)
  when 'UK' then format('£%.2f', amount).tr('.', ',')
  end
end

describe 'Currency converter' do
  it 'can properly format currency for US, Japan, and UK' do
    expect(
      currency_converter(5000, 'US')
    ).to eq('$5000.00')
    expect(currency_converter(5000, 'Japan')).to eq('¥5000')
    expect(currency_converter(5000, 'UK')).to eq('£5000,00')
  end
end

system 'rspec 31.rb' if __FILE__ == $PROGRAM_NAME
