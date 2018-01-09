
# https://www.crondose.com/2017/01/build-user-class-can-passed-block-set-values-ruby/
require 'rspec'
# doc
class User
  attr_accessor :name, :email

  def initialize
    yield(self) if block_given?
  end
end


describe 'Block User' do
  it 'Allows a user to be created with a block of values' do
    user = User.new do |u|
      u.name = 'Jordan'
      u.email = 'test@test.com'
    end

    expect(user.name).to eq('Jordan')
    expect(user.email).to eq('test@test.com')
  end

  it 'Allows a user to be created witout default values' do
    user = User.new
    user.name = 'Jordan'
    user.email = 'test@test.com'

    expect(user.name).to eq('Jordan')
    expect(user.email).to eq('test@test.com')
  end
end

system 'rspec 24.rb' if __FILE__ == $PROGRAM_NAME
