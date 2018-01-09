
# https://www.crondose.com/2017/01/code-interview-question-build-high-low-game-ruby/

def game
  num = rand 25
  puts 'Guess a number between 0 and 24'

  loop do
    answer_in = gets.chomp.to_i
    if answer_in == num
      puts 'Correct guess'
      break
    elsif answer_in > num
      puts 'Your guess is too high'
    elsif answer_in < num
      puts 'your guess is too low'
    end

  end

end

game if __FILE__ == $PROGRAM_NAME
