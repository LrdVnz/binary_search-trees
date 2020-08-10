require 'pry'
load 'node.rb'
load 'comparable.rb'

# tree class
class Tree
  include Comparable
  attr_reader :tree, :root
  def initialize
    @root = nil
    @tree = []
  end

  def build(array)
    @array = array
    array.sort!.uniq!
    build_tree(array)
    breadth_first
    find_levels
    pretty_print
  end

  def insert(node)
  insert_method(node)
  update
  end

  def insert_method(node, root = @tree[0])
    if root.left.nil? && node < root.value
    return root.left = Node.new(node)
    elsif root.right.nil? && node > root.value
    return root.right = Node.new(node)
    end
      if node < root.value
        insert_method(node, root.left)
      elsif node > root.value
        insert_method(node, root.right)
      end
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

  def update
    breadth_first
    newarr = @output
    otherarr = newarr.delete_if { |a| a == 'nil' }
    build_tree(@output)
    breadth_first
    find_levels
    pretty_print
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

  def postorder
    root = tree[0]
    until root.nil?
      puts root.left.value unless root.left.nil?
      puts root.right.value unless root.right.nil?
      puts root.value
      puts '---------'
      root = root.left
    end
  end

  def delete(node)
    delete_method(node, @tree[0])
    update
  end

  def delete_method(node, root)
    if node == root.value
      puts "root found ||| #{root}"
      puts "root.value ||| #{root.value}"
      pos = @tree.index(root)
      puts "pos return ||| #{pos}"
      puts "tree pos #{@tree[pos].value}"
      puts "root #{root.value}"
      if root.right.nil? && root.left.nil?
        puts 'condition checked ------'
        return @tree[pos].value = 'nil'
      elsif !root.right.nil?
        return delete_with_children(@tree[pos].right, pos)
      elsif !root.left.nil?
        return delete_with_children(@tree[pos], pos)
      end
    end
    puts "root ||| #{root.value}"
    puts "root left #{root.left}"
    puts "root right #{root.right}"
    if node < root.value
      delete_method(node, root.left)
    elsif node > root.value
      delete_method(node, root.right)
    elsif node == root.value
      delete_method(node, root)
    end
  end

  def delete_with_children(root, pos)
    if root.left.nil?
      subpos = @tree.index(root)
      puts "subpos ||| #{subpos}"
      @tree[pos].value = root.value
      if !root.right.nil?
        replace_node_children(root.right, subpos)
      else
        @tree[subpos] = nil
      end
    end
    puts "child_root |||| #{root.value}"
    puts "pos child |||| #{pos}"
    if !root.left.nil?
      delete_with_children(root.left, pos)
    elsif !root.left.nil?
      delete_with_children(root.left, pos)
    end
  end

  def replace_node_children(root, pos)
    if root.left.nil? && root.right.nil?
      subpos = @tree.index(root)
      puts "(replace base case) subpos ||| #{subpos}"
      puts "(replace base case) tree subpos #{@tree[subpos].value}"
      puts "(replace base case) root value #{root.value}"
      puts "(replace base case) pos ||| #{pos}"
      puts "(replace base case) tree pos #{@tree[pos].value}"
      @tree[pos].value = root.value
      return @tree[subpos].value = 'nil'
    end
    puts "(replace) root |||| #{root.value}"
    puts "(replace) pos |||| #{pos}"
    if !root.left.nil?
      delete_with_children(root.left, pos)
    elsif !root.left.nil?
      delete_with_children(root.left, pos)
    end
  end

  def build_tree(array, start = 0, last = (array.length - 1))
    return nil if start > last

    middle = (start + last) / 2
    puts 'middle ||||| '
    p middle
    puts 'array ||||| '
    p array
    root = Node.new(array[middle])
    @tree << root
    root.left = build_tree(array, start, middle - 1)
    root.right = build_tree(array, middle + 1, last)
    root
  end

  def breadth_first(root = @tree[0])
    queue = []
    @output = []
    queue << root
    until queue_is_empty?(queue)
      current = queue.shift
      if current != '-'
        queue << (current.left || '-')
        queue << (current.right || '-')
        @output << current.value
      else
        @output << '-'
        queue << '-'
        queue << '-'
      end
    end
    puts "output |||| #{@output}"
    @output
  end

  def queue_is_empty?(array)
    is_empty = true
    array.each { |e| is_empty = false if e != '-' }
    is_empty
  end

  def find_levels
    @all_levels = []
    level = 0
    remaining = @output
    until remaining.empty?
      n = 2**level
      @all_levels << remaining.take(n)
      remaining = remaining.drop(n)
      level += 1
    end
    puts "all levels ||||||||| #{@all_levels}"
    @all_levels
  end

  def print_tree
    num = 9
    @all_levels.each do |arr|
      spaces = ' ' * num
      p arr.join(spaces).center(50)
      num -= 2
    end
  end

  def pretty_print(node = @tree[0], prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
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

  def balanced?(node = @tree[0], num = 0, levels = [], isbalanced = true)
    if node.nil?
      levels << num
      num = 0
      if levels.length >= 2
        levels.sort!
        isbalanced = false if (levels[-1] - levels[-2]) > 1 || (levels[-1] - levels[-2]) < 0
      end
      return isbalanced
   end
    puts "verify_node |||| #{node}"
    puts "verify_num ||| #{num}"
    puts "verify_levels ||| #{levels}"
    puts '---------------------'

    balanced?(node.right, num + 1, levels, isbalanced)
    balanced?(node.left, num + 1, levels, isbalanced)
  end
end

tree = Tree.new
array = [1, 2, 3, 4, 5, 9, 10, 23, 24]
tree.build(array)
binding.pry
