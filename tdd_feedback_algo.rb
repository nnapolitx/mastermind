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
      guess[i] = 'N'
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
