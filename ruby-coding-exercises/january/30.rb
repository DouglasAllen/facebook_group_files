
# https://www.crondose.com/2017/01/using-retry-method-inside-ruby-rescue-block/
require 'rspec'
#
class ApiConnector
  attr_accessor :attempts, :errors

  def initialize
    @attempts = 0
    @errors = []
  end

  def send_data
    @attempts += 1
    api_call
  rescue Errno::ETIMEDOUT => e
    errors << e
    retry if @attempts < 3
  end

  def api_call
    raise Errno::ETIMEDOUT
  end
end

describe 'ApiConnector' do
  it 'attempts to connect with an API 3 times and \
  stores the errors in an array' do
    err = '#<Errno::ETIMEDOUT: A connection attempt failed because the' \
          ' connected party did not properly respond after a period of time,' \
          ' or established connection failed because connected host' \
          ' has failed to respond.>'
    api = ApiConnector.new
    api.send_data
    expect(api.attempts).to eq(3)
    expect(
      api.errors.to_s
    ).to eq("[#{err}, #{err}, #{err}]")
  end
end

system 'rspec 30.rb' if __FILE__ == $PROGRAM_NAME
