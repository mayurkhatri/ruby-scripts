# arrays -> 9
# fixed cells containing values
# note the column and row number of fixed cells

# Rules when entering the values for empty cells :
# 1. The value's desired column and row value should not be
# that of any fixed cell

require 'set'

class Sudoku

end

class Board

  def initialize
    @board = Array.new(9)
    9.times do |i|
      @board[i] = generate_row
    end
  end

  def rand_n(n, max)
      randoms = Set.new
      loop do
          randoms << rand(max)
          return randoms.to_a if randoms.size >= n
      end
  end

  def rand_set_n(n, max, random_nums)
    total_rand = rand(1..6)
    # positions in array where we have to fill numbers
    positions = rand_n(total_rand, max)
    # random numbers which will be used to fill positions
    generated_numbers = rand_n(n, max)
    i = 0
    positions.each do |position|
      random_nums[position] = generated_numbers[i]
      i = i + 1
    end
    puts "printing random numbers"
    p random_nums
  end

  def generate_row
    rand_arr = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    row_set = rand_set_n(6, 9, rand_arr)
  end

  def show_board
    @board.each {|arr| puts arr.inspect}
  end
end

class Player

end

game = Board.new
game.show_board