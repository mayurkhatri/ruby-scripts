class InsertionSort
  def insertionsort(input_array)
    for index in 1..input_array.length-1
      current_element = input_array[index]
      position = index

      while (input_array[position - 1] > current_element && position > 0) do
      	puts position
      	input_array[position] = input_array[position - 1]
      	position = position - 1
      end

      input_array[position] = current_element
    end

    return input_array
  end
end

#[22, 44, 11, 9, 8, 4]
input_array = Array.new(23) { rand(10..40) }
p input_array
output_array = InsertionSort.new.insertionsort(input_array)
p output_array

# Starting from index 1 of an array compare the element at the index with all
# the elements on left side.
# Shift the greater elements which are on left side of current element to right by
# comparing the current_element with all the left hand side elements.
# And move / insert the current_element to left if you find a larger element than it.