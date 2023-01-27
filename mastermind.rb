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
  gets.chomp
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

def generate_feedback(guess, test_answer)
  answer = test_answer.dup
  feedback = []
  guess = guess.split('').map(&:to_i)
  guess.each_with_index do |n, i|
    next unless answer.include?(n)

    j = answer.index(n)
    if guess.count(n) > 1 && j != i && answer.count(n) < guess.count(n)
      guess[i] = 'N'
    elsif guess.count(n) > 1 && n != answer[i] && j != i && answer.count(n) >= guess.count(n)
      feedback.push('O')
      guess[i] = 'N'
    elsif n == answer[i]
      feedback.push('X')
      guess[i] = 'N'
      answer[i] = 'N'
    else
      feedback.push('O')
      guess[i] = 'N'
      answer[j] = 'N'
    end
  end
  puts feedback.sort.join('')
end

def display_win(num, player)
  puts "You win, #{num} is the answer!\nWould you like to play again? (Y/N)"
  if gets.chomp.upcase == 'Y'
    player.reset_count
    gameflow(generate_code, player)
  else
    exit!
  end
end

def generate_code
  master_code = Mastmind.new
  master_code.mast
end

def player_guess(num, answer, player)
  if num == answer.join('')
    display_win(num, player)
  else
    generate_feedback(num, answer)
  end
  gameflow(answer, player)
end

def gameflow(answer, player)
  player.make_guess
  if player.guess > 12
    puts "Sorry, The answer was #{answer}\ngame over ;(\nWould you like to play again? (Y/N)"
    if gets.chomp.upcase == 'Y'
      player.reset_count
      gameflow(generate_code, player)
    else
      exit!
    end
  else
    puts "This is round #{player.guess}. Guess the code!"
    player_guess(input_guess, answer, player)
  end
end

def input_guess
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
