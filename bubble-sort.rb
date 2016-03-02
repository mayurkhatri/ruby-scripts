class BubbleSort
  def bubblesort(input_array)
    puts "bubble sort"
    p input_array
    loop do
    	swapped = false
	    for i in 0..(input_array.length - 2)
	      if input_array[i] > input_array[i+1]
			 		temp = input_array[i]
			 		input_array[i] = input_array[i+1]
			 		input_array[i+1] = temp
			 		swapped = true
	      end # end if
	    end # end for
	    return input_array if swapped == false
    end  # end loop
  end
end
array = Array.new(4) { rand(1..100) }
arr = BubbleSort.new.bubblesort(array)
puts "final array"
p arr