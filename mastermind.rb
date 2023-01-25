# frozen_string_literal: true

# pseudocode for help
# Need to set up an instructions and begin game prompt in a method.
# Computer will randomly generate code (4 digits with numbers 1-6)
# user will have 12 rounds to guess.
# Computer will provide feedback using X's for correct number and position
# O's for correct number wrong position

def display_instructions
  puts "Welcome to MASTERMIND\n
  The object of this game is to guess the 4 digit code that uses numbers 1-6.
  The numbers can repeat, for example, 1166 is a valid code, and so is 2222.
  The guesser will have a total of 12 guesses to solve the code.
  After each guess, a prompt will display feedback.
  O means that a number is correct, but not in the right position.
  An X means that a number is correct and in the correct postion.
  If no number is correct, no feedback will be displayed.\n
  Are you ready to crack the code? Enter your name to begin.\n"
  name = gets.chomp
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

  def new_game
    @guess = 0
  end
end

def validate_guess(guess)
  if guess.length > 4
    puts "#{guess} is invalid, enter a four digit number with only numbers 1-6."
    false
  elsif guess.all? { |val| val > 7 || val < 1 }
    puts "#{guess} is invalid, enter a four digit number with only numbers 1-6."
    false
  else
    true
  end
end

def generate_feedback(num, answer)
  # push the chars in the num to an array.
  # check to see if includes? num, then
  # check to see if index is correct, return X, if only includes return O
  # if none of above, return nothing
  # step to next guess
end

def display_win
  puts 'you win'
  exit!
end

def generate_code
  master_code = Mastmind.new
  master_code.mast
end

def player_guess(num, answer, player)
  if num == answer
    display_win(num)
  else
    generate_feedback(num, answer)
  end
  gameflow(answer, player)
end

def gameflow(answer, player)
  if player.guess > 11
    puts 'game over ;('
    exit!
  else
    puts "This is round #{player.guess + 1}. Guess the code!"
    new_guess = gets.chomp
    if validate_guess(new_guess)
      player_guess(new_guess)
    else
      gameflow(answer, player)
    end
  end
end

def input_guess
  # get the input
  # validate it
  # turn it into an array
  # push it to gameflow or player_guess method
end

name = display_instructions
player = Human.new(name)
x = generate_code
p x
p player.name
p player.guess
gameflow(x, player)
