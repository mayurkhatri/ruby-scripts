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
    @board_without_dup = @board
  end

  def rand_n(n, max)
    randoms = Set.new
    loop do
      randoms << rand(max)
      return randoms.to_a if randoms.size >= n
    end
  end

  def rand_set_n(n, max, random_nums)
    # remove last line to check bug
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
    p "**** in show_board"
    p @board
    @board.each {|arr| puts arr.inspect}
  end

  def make_column_value_uniq

  end

  def get_column_elements(column_no)
    column_array = []
    @board.each do |element|
      column_array << element[column_no]
      column_array = column_array.reject{ |e| e === 0}
    end
  end

  def get_region_numbers(region_num)
    region_num = region_num.to_i
    case region_num
    when 1
      region_array = []
      region_array << @board_without_dup[0][0..2]
      region_array << @board_without_dup[1][0..2]
      region_array << @board_without_dup[2][0..2]
      region_array
    when 2
      region_array = []
      region_array << @board_without_dup[0][3..5]
      region_array << @board_without_dup[1][3..5]
      region_array << @board_without_dup[2][3..5]
      region_array
    when 3
      region_array = []
      region_array << @board_without_dup[0][6..8]
      region_array << @board_without_dup[1][6..8]
      region_array << @board_without_dup[2][6..8]
      region_array
    when 4
      region_array = []
      region_array << @board_without_dup[3][0..2]
      region_array << @board_without_dup[4][0..2]
      region_array << @board_without_dup[5][0..2]
      region_array
    when 5
      region_array = []
      region_array << @board_without_dup[3][3..5]
      region_array << @board_without_dup[4][3..5]
      region_array << @board_without_dup[5][3..5]
    when 6
      region_array = []
      region_array << @board_without_dup[3][6..8]
      region_array << @board_without_dup[4][6..8]
      region_array << @board_without_dup[5][6..8]
      region_array
    when 7
      region_array = []
      region_array << @board_without_dup[6][0..2]
      region_array << @board_without_dup[7][0..2]
      region_array << @board_without_dup[8][0..2]
      region_array
    when 8
      region_array = []
      region_array << @board_without_dup[6][3..5]
      region_array << @board_without_dup[7][3..5]
      region_array << @board_without_dup[8][3..5]
      region_array
    when 9
      region_array = []
      region_array << @board_without_dup[6][6..8]
      region_array << @board_without_dup[7][6..8]
      region_array << @board_without_dup[8][6..8]
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
    duplicate_col_nos.to_a
  end

  def remove_column_dup
    # working fine
    @board.each {|arr| puts arr.inspect}
    @transpose_board = @board.transpose
    duplicate_col_nos = get_column_no_with_duplicates
    unless duplicate_col_nos.empty?
      duplicate_col_nos.each do |col|
        row_with_dups = @transpose_board[col]
        already_occured = []
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
    @board_without_dup = @transpose_board.transpose
  end

  def region_with_dup
    # returns array of ids of regions which contain duplicate value
    dup_region_ids = []
    (1..9).each do |region_num|
      nums = get_region_numbers(region_num)
      nums = nums.flatten
      if nums.uniq.length != nums.length
        dup_region_ids << region_num
      end
    end
  end

  def find_duplicates(array)
    dup_occ = array.select{ |e| array.count(e) > 1}
    dup_occ.uniq
  end

  def remove_region_duplicates
    @board.each {|arr| puts arr.inspect}
    (1..9).each do |region_num|
      p @board_without_dup
      region_elements = get_region_numbers(region_num)
      #get_region_dups = find_duplicates(region_elements)
      #p "region duplicates"
      #p get_region_dups
      #p "region duplicates and their occurance index"
      #elem_index = {}
      # get_region_dups.each do |ele| elem_index[ele] =  region_elements.each_index.select{ |i|  region_elements[i] == ele} unless ele==0 end

      # elem_index.each { |k, v| v.shift; elem_index[k] = v }
      occurred = []
      p @board_without_dup
      region_elements.each do |region_row|
        i = 0
        p region_row
        region_row.each do |element|
          if occurred.include? element
            region_row[i] = 0
          else
            occurred << element
          end
          i = i + 1
        end
      end
      board_without_dup(region_elements, region_num)
    end
    p "Printing board"
    @board.each {|arr| puts arr.inspect}
    p "Final board without duplicates ******"
    @board_without_dup.each {|arr| puts arr.inspect}
  end

  def board_without_dup(region_elements, region_num)
    if region_num == 1
      for i in 0..2 do
        @board_without_dup[i][0..2] = region_elements[i]
      end
    elsif region_num == 2
      for i in 0..2 do
        @board_without_dup[i][3..5] = region_elements[i]
      end
    elsif region_num == 3
      for i in 0..2 do
        @board_without_dup[i][6..8] = region_elements[i]
      end
    elsif region_num == 4
      p region_num
      for i in 3..5 do
        @board_without_dup[i][0..2] = region_elements[i-3]
      end
    elsif region_num == 5
      for i in 3..5 do
        @board_without_dup[i][3..5] = region_elements[i-3]
      end
    elsif region_num == 6
      for i in 3..5 do
        p region_elements[i]
        @board_without_dup[i][6..8] = region_elements[i-3]
      end
    elsif region_num == 7
      for i in 6..8 do
        @board_without_dup[i][0..2] = region_elements[i-6]
      end
    elsif region_num == 8
      for i in 6..8 do
        @board_without_dup[i][3..5] = region_elements[i-6]
      end
    elsif region_num == 9
      for i in 6..8 do
        @board_without_dup[i][6..8] = region_elements[i-6]
      end
    end
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
#game.get_column_no_with_duplicates
game.remove_column_dup
game.remove_region_duplicates

# while entering numbers in aimed filled shells, check
# if it exists in it's column or line or region.
# if yes then regenerate another random number till it's unique in
# the line/column/region