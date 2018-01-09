
# https://www.crondose.com/2017/02/sort-collection-struct-objects-one-attributes-ruby/

require 'rspec'

def total_sorter(invoices)
  invoices.sort_by(&:total).reverse
end

describe 'Invoice sorter' do
  it 'sorts a set of invoices by their totals' do
    Invoice = Struct.new(:name, :total, :category)
    google = Invoice.new('Google', 500, 'Marketing')
    amazon = Invoice.new('Amazon', 1000, 'eCommerce')
    yahoo = Invoice.new('Yahoo', 300, 'Marketing')

    invoices = [google, amazon, yahoo]

    expect(total_sorter(invoices).first.name).to eq('Amazon')
    expect(total_sorter(invoices).last.name).to eq('Yahoo')
  end
end

system 'rspec 10.rb' if __FILE__ == $PROGRAM_NAME
