# node class
class Node
  attr_reader :value, :left, :right
  attr_writer :value
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def left=(left)
    @left = (left unless left.nil?)
  end

  def right=(right)
    @right = (right unless right.nil?)
  end
end
