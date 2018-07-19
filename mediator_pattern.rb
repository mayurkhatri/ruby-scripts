# for text field input
class TextField
  attr_accessor :value

  def initialize
    @value = ""
  end
end

# Observer for TextField class
class TextFieldObserver < TextField
  attr_accessor :observers
  def initialize
    @observers = []
    super
  end

  def value=(value)
    super
    @observers.each { |observer| observer.text_value_changed }
  end
end

# For list of search words
class List
  attr_accessor :words
  def initialize(words)
    @words = words
  end
end

# attaches itself as a observer to TextField class
class Mediator
  def initialize(text_field, list)
    @text_field = text_field
    @text_field.observers << self
    @list = list
  end

  # returns the array of words based on the input text field changed value
  def text_value_changed
    puts "In text value changed"
    @list.words = @list.words.inject([]) do |new_list, word|
      if word.start_with?(@text_field.value)
        puts word
        new_list.push(word)
      end
      new_list
    end
  end
end

list = List.new(["simple", "strong", "new", "clear", "si"])

text_field = TextFieldObserver.new

mediator = Mediator.new(text_field, list)
text_field.value = "st"

puts list.words.inspect
