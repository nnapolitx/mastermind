# frozen_string_literal: true

# algo module for generating feedback on guesses
module FeedbackAlgo
  def copy_variables(guess, main_answer)
    answer = main_answer.dup
    guess = guess.split('').map(&:to_i)
    check_answer_includes_n(guess, answer)
  end

  def check_answer_includes_n(guess, answer, feedback = [])
    guess.each_with_index do |n, i|
      next unless answer.include?(n)

      feedback.push(check_duplicates(n, guess, answer, i))
    end
    puts feedback.sort.join('')
  end

  def check_duplicates(num, guess, answer, index, jdex = answer.index(num))
    if condition_one(guess, answer, num, jdex, index)
      guess[index] = 'N'
    elsif condition_two(guess, answer, num, jdex, index)
      guess[index] = 'N'
      'O'
    else
      check_n_position(guess, answer, num, jdex, index)
    end
  end

  def check_n_position(guess, answer, num, jdex, index)
    guess[index] = 'N'
    if num == answer[index]
      answer[index] = 'N'
      'X'
    else
      answer[jdex] = 'N'
      'O'
    end
  end

  def condition_one(guess, answer, num, index_a, index_g)
    guess.count(num) > 1 && index_a != index_g && answer.count(num) < guess.count(num)
  end

  def condition_two(guess, answer, num, index_a, index_g)
    guess.count(num) > 1 && num != answer[index_g] && index_a != index_g && answer.count(num) >= guess.count(num)
  end
end

# create a code
class Mastmind
  attr_reader :mast

  def initialize
    @mast = Array.new(4) { rand(1..6) }
  end
end

# class for human player
class Human
  attr_reader :name, :guess

  def initialize(name, guess = 0)
    @name = name
    @guess = guess
  end

  def make_guess
    @guess += 1
  end

  def reset_count
    @guess = 0
  end
end

# all messages to user are stored here
module DisplayMessages
  def instructions
    puts "Welcome to MASTERMIND\n
    The object of this game is to guess the 4 digit code that uses numbers 1-6.
    The numbers can repeat, for example, 1166 is a valid code, and so is 2222.
    The guesser will have a total of 12 guesses to solve the code.
    After each guess, a prompt will display feedback.
    O means that a number is correct, but not in the right position.
    An X means that a number is correct and in the correct postion.
    If no number is correct, no feedback will be displayed.\n
    Are you ready to crack the code? Enter your name to begin.\n"
    gets.chomp
  end

  def win_message(answer)
    puts "You win, #{answer} is the answer!\nWould you like to play again? (Y/N)"
    gets.chomp.upcase
  end

  def loss_message(answer)
    puts "Sorry, the answer was #{answer}\nGAME OVER :(\nWould you like to play again? (Y/N)"
    gets.chomp.upcase
  end

  def new_round(round)
    puts "This is round #{round}. Crack the code!"
  end

  def input_error(input)
    puts "Sorry, #{input}, is not a valid guess.\n
    Please pick only 4 numbers ranging from 1 to 6\n"
  end
end

# Contains all methods for playing as code breaker.
module CodeBreaker
  include DisplayMessages
  include FeedbackAlgo

  def make_player
    Human.new(instructions)
  end

  def generate_code
    code = Mastmind.new
    code.mast
  end

  def display_loss(player, answer)
    if loss_message(answer) == 'Y'
      player.reset_count
      display_round(generate_code, player)
    else
      exit!
    end
  end

  def display_win(player, answer)
    if win_message(answer) == 'Y'
      player.reset_count
      display_round(generate_code, player)
    else
      exit!
    end
  end

  def display_round(answer, player)
    player.make_guess
    if player.guess > 12
      display_loss(player, answer)
    else
      new_round(player.guess)
      review_guess(input_guess, answer, player)
    end
  end

  def input_guess
    input = gets.chomp
    if input.size > 4 || input.nil? || input.length < 4 || input.split('').any? { |num| num.to_i > 6 || num.to_i < 1 }
      input_error(input)
      input_guess
    else
      input
    end
  end

  def review_guess(guess, answer, player)
    if guess == answer.join('')
      display_win(player, answer)
    else
      copy_variables(guess, answer)
    end
    display_round(answer, player)
  end
end

# start a new game
class PlayGame
  include CodeBreaker

  def initialize
    @new_game = display_round(generate_code, make_player)
  end
end

play = PlayGame.new
play.initialize
# use gameflow method but refactor first conditional to single method
# turn gameplay into a module or class, possibly
# possibly make some methods private on the feedback algo
