# arrays -> 9
# fixed cells containing values
# note the column and row number of fixed cells

# Rules when entering the values for empty cells :
# 1. The value's desired column and row value should not be
# that of any fixed cell

# Rules for region (3x3 sub grid) :
# The region should have nos between 1-9 with
# unique numbers in each grid

require 'set'

class Sudoku

end

class Board
  def initialize
    @board = Array.new(9)
    9.times do |i|
      @board[i] = generate_row
    end
    @transpose_board = @board.transpose
  end

  def rand_n(n, max)
    randoms = Set.new
    loop do
      randoms << rand(max)
      return randoms.to_a if randoms.size >= n
    end
  end

  def rand_set_n(n, max, random_nums)
    total_rand = rand(1..n)
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
    row_set = rand_set_n(9, 9, rand_arr)
  end

  def show_board
    puts "printing board"
    @board.each {|arr| puts arr.inspect}
    puts "priting after transpose"
    transpose_array = @board.transpose
    transpose_array.each {|arr| puts arr.inspect}
  end

  def make_column_value_uniq

  end

  def get_column_elements(column_no)
    column_array = []
    @board.each do |element|
      column_array << element[column_no]
      column_array = column_array.reject{ |e| e === 0}
    end
    p "Printing column contents for col with index #{column_no}"
    p column_array
  end

  def get_region_numbers(region_num)
    region_num = region_num.to_i
    case region_num
    when 1
      region_array = []
      region_array << @board[0][0..2]
      region_array << @board[1][0..2]
      region_array << @board[2][0..2]
      p region_array
    when 2
      region_array = []
      region_array << @board[0][3..3]
      region_array << @board[1][3..3]
      region_array << @board[2][3..3]
      region_array
    when 3
      region_array = []
      region_array << @board[0][6..3]
      region_array << @board[1][6..3]
      region_array << @board[2][6..3]
      region_array
    when 4
      region_array = []
      region_array << @board[3][0..2]
      region_array << @board[4][0..2]
      region_array << @board[5][0..2]
      region_array
    when 5
      region_array = []
      region_array << @board[3][3..3]
      region_array << @board[4][3..3]
      region_array << @board[5][3..3]
      region_array
    when 6
      region_array = []
      region_array << @board[3][6..3]
      region_array << @board[4][6..3]
      region_array << @board[5][6..3]
      region_array
    when 7
      region_array = []
      region_array << @board[6][0..2]
      region_array << @board[7][0..2]
      region_array << @board[8][0..2]
      region_array
    when 8
      region_array = []
      region_array << @board[6][3..3]
      region_array << @board[7][3..3]
      region_array << @board[8][3..3]
      region_array
    when 9
      region_array = []
      region_array << @board[6][6..3]
      region_array << @board[7][6..3]
      region_array << @board[8][6..3]
      region_array
    end
  end

  def get_column_no_with_duplicates
    duplicate_col_nos = []
    @transpose_board.each_with_index do |row, i|
      row = row.reject{|e| e == 0}
      if row.uniq.length != row.length
        duplicate_col_nos << i
      end
    end
    p "printing duplicate column index"
    duplicate_col_nos.to_a
  end

  def remove_column_dup
    duplicate_col_nos = get_column_no_with_duplicates
    p "duplicate column nos"
    p duplicate_col_nos
    unless duplicate_col_nos.empty?
      duplicate_col_nos.each do |col|
        puts "column num"
        p col
        row_with_dups = @transpose_board[col]
        already_occured = []
        puts "row with dups"
        p row_with_dups
        row_with_dups.each_with_index do |ele, index|
          if already_occured.include? ele
            # replace duplicates with zero(let the first occurance of duplicate element remain)
            #@transpose_board[index] = 0
            @transpose_board[col][index] = 0
          end
          already_occured << ele
        end
      end
    end
  end

  def remove_region_duplicates
    puts "In remove region duplicates"
    (1..9).each do |region_num|
      nums = get_region_numbers(region_num)

    end
    nums = get_region_numbers(1)
    nums.each {|e| puts e}
  end

  def print_transpose
    puts "transposed board"
    @transpose_board.each{|arr| puts arr.inspect}
    puts "oneline"
    p @transpose_board[0]
  end

  def print_board_index
    i = 0
    @board.each_with_index do |row|
      row_elements
      row.each_with_index do |element, index|
        elem_hash = Hash.new
        p i.to_s + ", " + index.to_s

      end
      i = i + 1
    end
  end
end

class Player

end

game = Board.new
game.show_board
game.get_column_no_with_duplicates
game.remove_column_dup
game.remove_region_duplicates
game.print_transpose

(1..9).each do |region_no|
  game.get_region_numbers(region_no)
end

# while entering numbers in aimed filled shells, check
# if it exists in it's column or line or region.
# if yes then regenerate another random number till it's unique in
# the line/column/region