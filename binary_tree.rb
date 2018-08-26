class Tree
  attr_accessor :root_node
  def initialize
    @root_node
  end

  def add_child(node)
    if @root_node.nil?
      @root_node = node
    else
      @root_node.add_child(@root_node, node)
    end
  end

  def pre_order(node)
    return [] if node.nil?
    results = []
    results << node.value
    results.concat pre_order(node.left)
    results.concat pre_order(node.right)
    results
  end

  def mirror_image
    if root_node.nil?
      puts "no elements present in tree"
    else
      root_node.mirror_image
    end
  end
end

class Node
  attr_accessor :left, :right
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def add_child(parent, node)
    if parent.value > node.value
      if parent.left.nil?
        parent.left = node
      else
        add_child(parent.left, node)
      end
    elsif parent.value < node.value
      if parent.right.nil?
        parent.right = node
      else
        add_child(parent.right, node)
      end
    end
  end

  def mirror_image
    self.left.mirror_image if !self.left.nil?
    self.right.mirror_image if !self.right.nil?

    temp = self.left
    self.left = self.right
    self.right = temp
  end
end

# initial setup
tree = Tree.new
# node = Node.new(5)
# tree.add_child(node)

root = Node.new("I")
tree.add_child(root)
# first level
root.left = Node.new("O")
root.right = Node.new("H")

# second level
root.left.left = Node.new("L")
root.left.right = Node.new("R")
root.right.left = Node.new("T")
root.right.right = Node.new("M")

# third level
root.left.left.left = Node.new("A")
root.left.left.right = Node.new("G")

# pre_order = tree.pre_order(root)
# p pre_order

tree.mirror_image
pre_order = tree.pre_order(root)
p pre_order
