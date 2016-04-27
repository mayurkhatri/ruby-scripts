require 'set'
class Sudoku
  def initialize
    @solution = []
    @board = []
  end
  def generate_solution
    initial_sequence = (1..9).to_a.shuffle
    first_chunk_combinations = get_combinations(initial_sequence[0..2])
    second_chunk_combinations = get_combinations(initial_sequence[3..5])
    third_chunk_combinations = get_combinations(initial_sequence[6..8])
    first_row = []
    second_row = []
    third_row = []

    first_row << first_chunk_combinations[0]
    first_row << second_chunk_combinations[0]
    first_row << third_chunk_combinations[0]

    second_row << first_chunk_combinations[1]
    second_row << second_chunk_combinations[1]
    second_row << third_chunk_combinations[1]

    third_row << first_chunk_combinations[2]
    third_row << second_chunk_combinations[2]
    third_row << third_chunk_combinations[2]

    first_band = get_combinations(first_row)
    second_band = get_combinations(second_row)
    third_band = get_combinations(third_row)

    p initial_sequence
    p first_row
    p second_row
    p third_row
    p "first_band"
    p first_band
    bands = []
    first_band.each {|row| p row.flatten}
    second_band.each {|row| p row.flatten}
    third_band.each {|row| p row.flatten}
    bands = [first_band, second_band, third_band]
    bands.each {|band| band.each{|row| @solution << row.flatten} }
    p "priting board"
    @solution.each {|row| p row}
  end

  def rand_n(n, max)
    randoms = Set.new
    min = min.to_i
    max = max.to_i
    n.times do
      randoms << rand(max)
    end
    return randoms.to_a
  end

  def prepare_board
    @board = @solution
    @board.each do |row|
      replacement_indexs = rand_n(5, 8)
      replacement_indexs.each do |index|
        row[index] = 0
      end
    end
  end

  def print_board
    p "priting board"
    @board.each {|row| p row}
  end

  def get_combinations(num_arr)
    combination_array = []
    combination_array << num_arr
    second_combination = num_arr.rotate(-1)
    combination_array << second_combination
    combination_array << second_combination.rotate(-1)
  end

  def set_fixed_locations
    @fixed_locations = []
    i = 1
    @board.each do |row|
      j = 1
      row.each do |ele|
        unless ele == 0
          @fixed_locations << [i, j]
        end
        j = j + 1
      end
      i = i + 1
    end
  end

  def get_fixed_locations
    p "fixed locations"
    p @fixed_locations
  end

  def valid_location?(row, column)
    if @fixed_locations.include?([row.to_i, column.to_i])
      false
    else
      true
    end
  end

  def set_board_ele(element, row, column)
    @board[row.to_i - 1][column.to_i - 1] = element.to_i
  end

  def get_board
    @board.each{|row| p row}
  end

  # tells the region number based on row and column value of input number
  def find_region_number(row_num, column_num)
    row_num = row_num.to_i
    column_num = column_num.to_i

    if row_num.between?(1,3) && column_num.between?(1,3)
      return 1
    elsif row_num.between?(1,3) && column_num.between?(4,6)
      return 2
    elsif row_num.between?(1,3) && column_num.between?(7,9)
      return 3
    elsif row_num.between?(4,6) && column_num.between?(1,3)
      return 4
    elsif row_num.between?(4,6) && column_num.between?(4,6)
      return 5
    elsif row_num.between?(4,6) && column_num.between?(7,9)
      return 6
    elsif row_num.between?(7,9) && column_num.between?(1,3)
      return 7
    elsif row_num.between?(7,9) && column_num.between?(4,6)
      return 8
    elsif row_num.between?(7,9) && column_num.between?(7,9)
      return 9
    end
  end

  def get_region_numbers(region_num)
    region_num = region_num.to_i
    case region_num
    when 1
      region_array = []
      region_array << @board[0][0..2]
      region_array << @board[1][0..2]
      region_array << @board[2][0..2]
      region_array
    when 2
      region_array = []
      region_array << @board[0][3..5]
      region_array << @board[1][3..5]
      region_array << @board[2][3..5]
      region_array
    when 3
      region_array = []
      region_array << @board[0][6..8]
      region_array << @board[1][6..8]
      region_array << @board[2][6..8]
      region_array
    when 4
      region_array = []
      region_array << @board[3][0..2]
      region_array << @board[4][0..2]
      region_array << @board[5][0..2]
      region_array
    when 5
      region_array = []
      region_array << @board[3][3..5]
      region_array << @board[4][3..5]
      region_array << @board[5][3..5]
    when 6
      region_array = []
      region_array << @board[3][6..8]
      region_array << @board[4][6..8]
      region_array << @board[5][6..8]
      region_array
    when 7
      region_array = []
      region_array << @board[6][0..2]
      region_array << @board[7][0..2]
      region_array << @board[8][0..2]
      region_array
    when 8
      region_array = []
      region_array << @board[6][3..5]
      region_array << @board[7][3..5]
      region_array << @board[8][3..5]
      region_array
    when 9
      region_array = []
      region_array << @board[6][6..8]
      region_array << @board[7][6..8]
      region_array << @board[8][6..8]
      region_array
    end
  end

  def valid_in_row?(row, element)
    row = row.to_i
    row_elements = @board[row - 1]
    row_elements = row_elements.flatten - [0]
    if row_elements.include?(element.to_i)
      return false
      #raise InvalidInputException
    else
      return true
    end
  end

  def valid_in_column?(column, element)
    column = column.to_i
    transposed_block = @board.transpose
    column_elements = transposed_block[column - 1]
    column_elements = column_elements.flatten - [0]
    #p column_elements
    if column_elements.include?(element.to_i)
      return false
      #raise InvalidInputException
    else
      return true
    end
  end

  def valid_in_region?(region_num, element)
    region_elements = get_region_numbers(region_num.to_i)
    region_elements = region_elements.flatten - [0]
    p "********************"
    p region_elements
    if region_elements.include?(element.to_i)
      return false
      #raise InvalidInputException
    else
      return true
    end
  end

  def valid_element?(element, row, column)
    element = element.to_i
    if element.between?(0, 9)
      region_num = find_region_number(row, column)
      return valid_in_region?(region_num, element) && valid_in_column?(column, element) && valid_in_row?(row, element)
    else
      puts "Invalid input.Please choose number between 1-9"
      return false
    end
  end

  def start_game
    puts "Enter row number(1-9)and column number(1-9) of location to input number at(eg. row_no, column_no)"
    location = gets.chomp
    begin
      location = location.split(",")
      row_no = location[0].strip
      column_no = location[1].strip
      p row_no
      p column_no
      if valid_location?(row_no, column_no)
        puts "Please enter the element to input"
        element = gets.chomp
        if valid_element?(element, row_no, column_no)
          set_board_ele(element, row_no, column_no)
          get_board
        else
          puts "Invalid element.."
        end
      else
        puts "Error : Fixed location requested.Please choose some other location"
        start_game
      end
      p
      start_game
    rescue StandardError => e
      puts "Error occurred : #{e}"
    end
  end
end
sudoku = Sudoku.new
sudoku.generate_solution
sudoku.prepare_board
sudoku.print_board
sudoku.set_fixed_locations
sudoku.start_game