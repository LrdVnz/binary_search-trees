require 'pry'
load 'node.rb'
load 'comparable.rb'

# tree class
class Tree
  attr_reader :tree, :root, :right_nodes, :left_nodes, :printed_array
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
    print_tree
  end

  def insert(node, root = @tree[0])
    if root.left_node.nil? && node < root.value
      pos = @tree.index(root)
      puts "pos ||| #{pos}"
      return @tree[pos].left_node = Node.new(node)
    elsif root.right_node.nil? && node > root.value
      pos = @tree.index(root)
      return @tree[pos].right_node = Node.new(node)
    end
    puts "root ||| #{root}"
    puts "node ||| #{node}"
    if node < root.value
      insert(node, root.left_node)
    elsif node > root.value
      insert(node, root.right_node)
    else
      return 'node already present'
    end
  end
  
  def delete(node)
   delete_method(node, @tree[0])
   update_tree
  end
   
  def find(node, root = @tree[0])
    if node == root.value
      pos = @tree.index(root)
      puts "node found. It is #{root}"
      puts "the index is : #{pos}"
      return "the value is : #{root.value}"
    end
    if node < root.value
      find(node, root.left_node)
    elsif node > root.value
      find(node, root.right_node)
    end
  end

  def level_order
   breadth_first
  end

  def update_tree
    breadth_first
    puts "thaoput |||| #{@output}"
    newarr = @output
    otherarr = newarr.delete_if{|a| a == "nil"}
    puts "ouput 222 ||| #{@output}"
    puts "cleaned output ||| #{otherarr}"
    build_tree(@output)
    breadth_first
    find_levels
    print_tree
  end
  
  def preorder(root = @tree[0]) 
   if root == nil 
     return
   end

   puts root.value 
   if root.left_node
   puts root.left_node.value
   else
   puts "nil"
   end 
   if root.right_node  
   puts root.right_node.value 
   else
    puts "nil"
   end
   puts "-----------"

   preorder(root.left_node)
   preorder(root.right_node)

  end
  
  def inorder(root = @tree[0])
   if root == nil 
     return
   end

  if root.left_node
  puts root.left_node.value
  else
  puts "nil"
  end 
  puts root.value
  if root.right_node  
  puts root.right_node.value 
  else
   puts "nil"
  end
  puts "-----------"

  inorder(root.left_node)
  inorder(root.right_node)

  end

  def postorder
    root = tree[0]
     until root == nil
      puts root.left_node.value unless root.left_node.nil?
      puts root.right_node.value unless root.right_node.nil?
      puts root.value
      puts "---------"
      root = root.left_node
     end
  end

  def delete_method(node, root)
    if node == root.value
      pos = @tree.index(root)
      puts "pos return ||| #{pos}"
      puts "tree pos #{@tree[pos].value}"
      puts "root #{root.value}"
      if root.right_node.nil? && root.left_node.nil?
       puts "condition checked ------"
       return @tree[pos].value = "nil"
      elsif !root.right_node.nil?
       return delete_with_children(@tree[pos].right_node, pos)
      elsif !root.left_node.nil?
       return delete_with_children(@tree[pos], pos)
      end
    end
    puts "root ||| #{root.value}"
    puts "root left #{root.left_node}"
    puts "root right #{root.right_node}"
    if node < root.value
      delete_method(node, root.left_node)
    elsif node > root.value
      delete_method(node, root.right_node)
    elsif node == root.value
      delete_method(node, root)
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
    root.left_node = build_tree(array, start, middle - 1)
    root.right_node = build_tree(array, middle + 1, last)
    root
  end

  def breadth_first(root = @tree[0])
    queue = []
    @output = []
    queue << root
    until queue_is_empty?(queue)
      current = queue.shift
      if current != 'nil'
        queue << if current.left_node
                   current.left_node
                 else
                   'nil'
                  end
        queue << if current.right_node
                   current.right_node
                 else
                   'nil'
                 end
        @output << current.value
      else
        @output << 'nil'
        queue << 'nil'
        queue << 'nil'
      end
    end
    puts "output |||| #{@output}"
    @output
  end

  def queue_is_empty?(array)
    is_empty = true
    array.each { |e| is_empty = false if e != 'nil' }
    is_empty
  end

  def delete_with_children(root, pos)
    if root.left_node.nil?
      subpos = @tree.index(root)
      puts "subpos ||| #{subpos}"
      @tree[pos].value = root.value
      if !root.right_node.nil?
       replace_node_children(root.right_node, subpos)
      else
       @tree[subpos] = nil 
      end
    end
    puts "child_root |||| #{root.value}"
    puts "pos child |||| #{pos}"
    if !root.left_node.nil?  
      delete_with_children(root.left_node, pos)    
    elsif !root.left_node.nil?
      delete_with_children(root.left_node, pos)
    end
  end
   
  def replace_node_children(root, pos)
    if root.left_node.nil? && root.right_node.nil?
      subpos = @tree.index(root)
      puts "(replace base case) subpos ||| #{subpos}"
      puts "(replace base case) tree subpos #{@tree[subpos].value}"
      puts "(replace base case) root value #{root.value}"
      puts "(replace base case) pos ||| #{pos}"
      puts "(replace base case) tree pos #{@tree[pos].value}"
      @tree[pos].value = root.value 
      return @tree[subpos].value = "nil"
    end
    puts "(replace) root |||| #{root.value}"
    puts "(replace) pos |||| #{pos}"
    if !root.left_node.nil?  
      delete_with_children(root.left_node, pos)    
    elsif !root.left_node.nil?
      delete_with_children(root.left_node, pos)
    end
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

  def horizontal_print(node = @tree[0], prefix="", is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right_node
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value.to_s}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left_node
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

  def balanced?(node = @tree[0], num = 0 , levels = [], isbalanced = true)
   if node == nil
    if levels.length > 2 
      levels = []
    end
    levels << num 
    num = 0 
    if levels.length == 2
      if levels[-1] - levels[-2] > 1 || levels[-1] - levels[-2] < 0 
      isbalanced = false
     end
    end
    return isbalanced
  end
    puts "verify_node |||| #{node}"
    puts "verify_num ||| #{num}"
    puts "verify_levels ||| #{levels}"
    puts "---------------------"

     balanced?(node.right_node, num + 1, levels, isbalanced) 
     balanced?(node.left_node, num + 1, levels, isbalanced)
  end

end

tree = Tree.new
array = [1, 2, 3, 4, 5, 9, 10 , 23, 24]
tree.build(array)
binding.pry
