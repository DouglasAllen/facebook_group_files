
# https://www.crondose.com/2017/01/build-html-heading-generator-ruby/
require 'rspec'

def title_creator(title)
  heading = %w(h1 title h1)
  heading[1] = title
  format('<%s>%s</%s>', heading[0], heading[1], heading[2])
end

describe 'HTML h1 converter' do
  it 'outputs an h1 tag given a title' do
    expect(title_creator('A Heading')).to eq('<h1>A Heading</h1>')
  end
end

system 'rspec 1.rb' if __FILE__ == $PROGRAM_NAME
