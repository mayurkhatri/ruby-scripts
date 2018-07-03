require "base64"

# enc   = Base64.encode64('Send reinforcements')
# Base64.encode64("sample string")


# encrypts i/p file contents and writes to a output file
class Encrypter
  def initialize
    arr = []
  end

  public
  def encrypt(input_file, output_file)
    while not input_file.eof?
      char = input_file.getc
      encoded_char = Base64.encode64(char)
      output_file.putc(encoded_char)
    end
    # char = input_file.getc
    # self.arr << Base64.encode64(char)
    # puts arr
  end
end

# Adapter class for strings if the input to encrypt method of Encrypter class is a string
# instead of a file for first parameter i.e input_file
class StringAdapter
  def initialize(str)
    @str = str
    @position = 0
  end

  def getc
    if @position >= @str.length
      raise EOFError
    else
      ch = @str[@position]
      @position = @position + 1
      return ch
    end
  end

  def eof?
    @position >= @str.length
  end
end

#input_file = File.new("test.txt", "a+")
input_file = StringAdapter.new("How are you?")
output_file = File.new("output.txt", "a+")
encrypter = Encrypter.new
encrypter.encrypt(input_file, output_file)

# now to provide a string as first parameter to encrypt method we need to use the StringAdapter
# class to make it compatible to Encrypter class(read class' encrypt method)



