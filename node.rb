# frozen_string_literal: true

# node class
class Node
  attr_accessor :value, :left, :right
  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end

  def node=(value)
    if value == 'nil'
      @value = 'nil'
      @left = 'nil'
      @right = 'nil'
    end
  end
end
