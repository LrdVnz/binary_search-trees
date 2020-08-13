# frozen_string_literal: true

# node class
class Node
  attr_reader :value, :left, :right
  attr_writer :value
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
  
  def node=(value)
   if value == 'nil'
    @value = 'nil'
    @left = 'nil'
    @right = 'nil'
   end
  end

  def left=(left)
    @left = left
  end

  def right=(right)
    @right = right
  end
end
