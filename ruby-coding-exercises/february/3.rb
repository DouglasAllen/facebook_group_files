
# https://www.crondose.com/2017/02/build-csv-file-generator-pure-ruby/
require 'rspec'
require 'csv'

# File needs to be created with the name and path of:
# support/generated_file.csv

def csv_tool(headers, data)
  CSV.open('support/generated_file.csv', 'wb') do |csv|
    csv << headers
    data.each do |col|
      csv << col
    end
  end
end

describe 'CSV generator' do
  it 'Creates a CSV file with the correct headers and rows' do
    headers = %w[Name Title Email]
    crm_data = [
      ['Darth Vader', 'CEO', 'betterthan@theforce.com'],
      ['Luke Skywalker', 'Dev', 'daddy@issues.com'],
      ['Kylo Ren', 'COO', 'daddy2@issues.com']
    ]

    p test_csv_file = File.read('support/crm.csv').gsub(/\r\n?/, "\n")

    csv_tool(headers, crm_data)

    p generated_file = File.read('support/generated_file.csv')

    expect(generated_file).to eq(test_csv_file)
  end
end

system 'rspec 3.rb' if __FILE__ == $PROGRAM_NAME
