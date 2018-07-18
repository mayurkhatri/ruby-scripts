class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def first
    @array[0]
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def has_next?
    @index < @array.length
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end

  def has_previous?
    @index > 0
  end

  def previous
    value = @array[@index]
    @index -= 1
    value
  end

  def rewind
    @index = 0
  end
end

arr = [1, 2, 3]
iterator = ArrayIterator.new(arr)

while iterator.has_next?
  puts iterator.next_item
end
