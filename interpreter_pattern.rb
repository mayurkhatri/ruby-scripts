require 'find'

class Expression

end

# returns all the files in a directory
class All < Expression
  def evaluate(dir)
    file_results = []
    Find.find(dir) do |file|
      if File.file?(p)
        file_results << p
      end
    end
    file_results
  end
end

# fetch files whose name match certain pattern
class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    file_results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      file_name = File.basename(p)
      file_results << p if File.fnmatch(@pattern, file_name)
    end
    puts file_results
  end
end

# file_name = FileName.new("*controller*")
# file_name.evaluate("app")

class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if( File.size(p) > @size)
    end
    results
  end
end

# search for writable files
class Writable < Expression
  def evaluate(directory)
    file_results = []
    Find.find(directory) do |f|
      next unless File.file?(f)
      file_results << File.basename(f) if File.writable?(f)
    end
    file_results
  end
end

# writable = Writable.new
# writable.evaluate("lib")


# below are the "nonterminals" for AST

class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    puts All.new(dir) - @expression.evaluate(dir)
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    results = @expression1.evaluate(dir) + @expression2.evaluate(dir)
    results.sort.uniq
  end
end


class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    results = @expression1.evaluate(dir) & @expression2.evaluate(dir)
    results.sort.uniq
  end
end

class Parser
  def initialize(input)
    @tokens = input.scan(/\(|\)|[\w\.\*]+/)
  end

  def next_token
    @tokens.shift
  end

  # return an Abstract syntax tree for the input string expression
  def expression
    puts "in expression method top"
    token = next_token
    if token.nil?
      nil
    elsif token == '('
      puts "token ( top"
      result = expression
      puts "result " + result.to_s
      puts "token ( bottom"
      raise 'Expected )' unless next_token == ')'
      result
    elsif token == 'all'
      puts "token all"
      All.new
    elsif token == 'writable'
      puts "token writable"
      Writable.new
    elsif token == 'bigger'
      puts "token bigger"
      Bigger.new(next_token.to_i)
    elsif token == 'filename'
      puts "token filename"
      FileName.new(next_token)
    elsif token == 'not'
      puts "token not"
      Not.new(expression)
    elsif token == 'or'
      puts "token or"
      Or.new(expression, expression)
    elsif token == 'and'
      puts "token and"
      And.new(expression, expression)
    else
      raise "Unexpected token: #{token}"
    end
  end
end

parser = Parser.new "and (and(bigger 1024) (filename *.haml)) writable"
ast = parser.expression

context = "."
result = ast.evaluate(context)
