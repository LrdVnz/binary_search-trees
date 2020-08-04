# node class
class Node
  attr_reader :value, :left_node, :right_node
  def initialize(value)
    @value = value
    @left_node = nil
    @right_node = nil
  end

  def left_node=(left_node)
    @left_node = (left_node unless left_node.nil?)
  end

  def right_node=(right_node)
    @right_node = (right_node unless right_node.nil?)
  end

  def value=(value)
    @value = value
  end

end
