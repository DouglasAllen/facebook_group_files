
# https://www.crondose.com/2017/02/build-csv-file-parsing-system-ruby/
require 'rspec'

def csv_parser(file_path)
  File.read(file_path).split(/\n/).map do |line|
    line.split(',')
  end
end

describe 'CSV Parser' do
  it 'parses a CSV file and stores each line as an array, \
  with each column as a separate element in the array' do
    final_data = [
      %w[Name Title Email],
      ['Darth Vader', 'CEO', 'betterthan@theforce.com'],
      ['Luke Skywalker', 'Dev', 'daddy@issues.com'],
      ['Kylo Ren', 'COO', 'daddy2@issues.com']
    ]
    expect(csv_parser('support/crm.csv')).to eq(final_data)
  end
end

system 'rspec 4.rb' if __FILE__ == $PROGRAM_NAME
