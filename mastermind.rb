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

def generate_feedback(num, answer)
  # push the chars in the num to an array.
  # check to see if includes? num, then
  # check to see if index is correct, return X, if only includes return O
  # if none of above, return nothing
  # step to next guess
  p answer
  num = num.split('').map(&:to_i)
  # check to see if array includes? each number; send to another method?
  num.map do |n|
    if answer.include?(n)
      # send to code_checker method
      puts "the code inclueds #{n}"
    else
      puts 'no feedback'
    end
  end
end

def display_win(num)
  puts "You win, #{num} is the answer!"
  exit!
end

def generate_code
  master_code = Mastmind.new
  master_code.mast
end

def player_guess(num, answer, player)
  puts num.split('')
  if num == answer.join('')
    display_win(num)
  else
    generate_feedback(num, answer)
  end
  gameflow(answer, player)
end

def gameflow(answer, player)
  player.make_guess
  if player.guess > 12
    puts 'game over ;('
    exit!
  else
    puts "This is round #{player.guess}. Guess the code!"
    player_guess(input_guess, answer, player)
  end
end

def input_guess
  # get the input
  # validate it for numbers and length
  # turn it into an array
  # push it to gameflow or player_guess method
  input = gets.chomp
  if input.size > 4 || input.nil? || input.length < 4 || input.split('').any? { |num| num.to_i > 6 || num.to_i < 1 }
    puts 'Please pick only 4 numbers ranging from 1 to 6'
    input_guess
  else
    input
  end
end

name = display_instructions
player = Human.new(name)
x = generate_code
gameflow(x, player)
