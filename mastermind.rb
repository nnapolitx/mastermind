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
  Are you ready to crack the code? Enter 1 to begin.\n"
end

def generate_code
  Array.new(4) { rand(1..6) }
end

# create a code
class Mastmind
  attr_reader :mast

  def initialize
    @mast = generate_code
  end
end

def validate_guess; end

def generate_feedback; end

def display_win; end

def gameflow; end

display_instructions
x = gets.chomp.to_i
if x == 1
  master_code = Mastmind.new
else
  puts 'exited'
  exit!
end
