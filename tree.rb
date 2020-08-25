load 'node.rb'
load 'comparable.rb'
load 'helpers.rb'
require 'pry'

# frozen_string_literal: true
# tree class
class Tree
  include Comparable
  include Helpers
  attr_reader :tree, :root
  def initialize
    @root = nil
    @tree = []
  end

  def build(array)
    @array = array
    array.sort!.uniq!
    build_tree(array)
    level_order
    find_levels
    pretty_print
  end

  def insert(node)
    insert_method(node)
    update
  end

  def delete(node)
    delete_method(node, @tree[0])
    update
  end

  def update
    level_order
    build_tree(@output)
    level_order
    find_levels
    pretty_print
  end

  def height(value)
    @all_levels.each_with_index do |arr, i|
      arr.each do |n|
        return i if n == value
      end
    end
  end

  def depth(value)
    @all_levels.reverse.each_with_index do |arr, i|
      arr.each do |n|
        return i if n == value
      end
    end
  end

  def balanced?
    @isbalanced = true
    balanced_method
    @isbalanced
  end

  def rebalance
    level_order
    newarr = @output
    otherarr = newarr.delete_if { |a| a == 'nil' }.sort
    @tree = []
    build_tree(otherarr)
    find_levels
    pretty_print
  end

  def find(node, root = @tree[0])
    if node == root.value
      pos = @tree.index(root)
      puts "node found. It is #{root}"
      puts "the index is : #{pos}"
      return "the value is : #{root.value}"
    end
    if node < root.value
      find(node, root.left)
    elsif node > root.value
      find(node, root.right)
    end
  end

  def build_tree(array, start = 0, last = (array.length - 1))
    return nil if start > last

    middle = (start + last) / 2
    root = Node.new(array[middle])
    @tree << root
    root.left = build_tree(array, start, middle - 1)
    root.right = build_tree(array, middle + 1, last)
    root
  end

  def level_order(root = @tree[0])
    queue = []
    @output = []
    queue << root
    until queue_is_empty?(queue)
      current = queue.shift
      if current != 'nil'
        queue << (current.left || 'nil')
        queue << (current.right || 'nil')
        @output << current.value
      else
        @output << 'nil'
        queue << 'nil'
        queue << 'nil'
      end
    end
    @output
  end

  def preorder(root = @tree[0])
    return if root.nil?

    puts root.value
    if root.left
      puts root.left.value
    else
      puts 'nil'
    end
    if root.right
      puts root.right.value
    else
      puts 'nil'
    end
    puts '-----------'
    preorder(root.left)
    preorder(root.right)
  end

  def inorder(root = @tree[0])
    return if root.nil?

    if root.left
      puts root.left.value
    else
      puts 'nil'
    end
    puts root.value
    if root.right
      puts root.right.value
    else
      puts 'nil'
    end
    puts '-----------'
    inorder(root.left)
    inorder(root.right)
  end

  def postorder(root = @tree[0])
    return if root.nil?

    if root.left
      puts root.left.value
    else
      puts 'nil'
    end
    if root.right
      puts root.right.value
    else
      puts 'nil'
    end
    puts root.value
    puts '-----------'
    postorder(root.left)
    postorder(root.right)
  end
end

tree = Tree.new
array = Array.new(15) { rand(1..100) }
tree.build(array)
puts 'is the tree balanced ?'
puts tree.balanced?
puts 'preorder'
tree.preorder
puts 'postorder'
tree.postorder
puts 'inyofaceorder'
tree.inorder
puts "let's ruin it"
tree.insert(112)
tree.insert(149)
tree.insert(234)
tree.insert(198)
tree.insert(201)
tree.insert(129)
puts "now should be unbalanced NOOOOO YOU CAN'T JUST UNBALANCE IT !!!!!! THAT'S MYSOGINISTICCCC"
puts tree.balanced?
puts 'yo rebalance yourself you weak ass tree!!!'
tree.rebalance
puts 'is this mf rebalance aghein???? qwiasjdweoweew'
puts tree.balanced?
puts 'hehehehehehe leeveeeel pooostmaloone preeeecarious inorderino'
tree.level_order
puts 'preorderinoooooo'
tree.preorder
puts 'postmalonerder'
tree.postorder
puts 'initsorder'
tree.inorder
puts '>THE END. FINALLY '
tree.pretty_print

binding.pry
