
# https://www.crondose.com/2017/01/ruby-coding-exercise-extract-random-element-collection-arrays-nested-hash/
require 'rspec'

menu = {
  'appetizers' => %w[Chips Quesadillas Flatbread],
  'entrees' => %w[Steak Chicken Lobster],
  'dessers' => %w[Cheesecake Cake Cupcake]
}

def daily_special(hash)
  menu_item = []
  hash.map { |category| menu_item << category.last }.flatten.sample
end

describe 'Nested hash element selector' do
  it 'selected a random element from the set of nested arrays' do
    expect(daily_special(menu).class).to eq(String)
  end
end

system 'rspec 7.rb' if __FILE__ == $PROGRAM_NAME
