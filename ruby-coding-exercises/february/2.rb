# https://www.crondose.com/2017/02/build-interval-timer-method-ruby/

def interval(secs)
  loop do
    yield
    sleep secs
  end
end

interval 2 do
  puts 'hey there'
end
