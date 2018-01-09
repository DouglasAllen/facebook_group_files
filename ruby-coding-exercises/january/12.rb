
# https://www.crondose.com/2017/01/build-pseudo-random-number-generator-follows-specific-sequence/
require 'rspec'

def pseudo_random(num)
  srand 1
  Fiber.new do
    num.times do
      Fiber.yield rand 100
    end
  end
end

describe 'Psudeo random number generator' do
  it 'creates the same sequence of random numbers' do
    random_sequence = pseudo_random 8
    expect(random_sequence.resume).to eq(37)
    expect(random_sequence.resume).to eq(12)
    expect(random_sequence.resume).to eq(72)
    expect(random_sequence.resume).to eq(9)
    expect(random_sequence.resume).to eq(75)
    expect(random_sequence.resume).to eq(5)
    expect(random_sequence.resume).to eq(79)
    expect(random_sequence.resume).to eq(64)
  end
end

system 'rspec 12.rb' if __FILE__ == $PROGRAM_NAME
