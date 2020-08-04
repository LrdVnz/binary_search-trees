require 'pry'
load 'Node.rb'
load 'Comparable.rb'

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
  
  def update_tree
      breadth_first
      find_levels
      print_tree
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
    while !queue_is_empty?(queue)
      current = queue.shift
      if current != 'nil'
        if current.left_node 
          queue << current.left_node 
         else 
          queue << 'nil'
         end
         if current.right_node
          queue << current.right_node
         else 
          queue << 'nil'
         end
         @output << current.value
       else   
        @output << 'nil'
        queue << 'nil'
        queue << 'nil'
       end
       puts "output ||||"
       puts "#{@output}"
      end
    puts "output||||| #{@output.join(" ")}"
    @output
  end

  def queue_is_empty?(array)
    isEmpty = true
    array.each{ |e| isEmpty = false if e != 'nil' }
    return isEmpty
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
    @all_levels.each_with_index do |arr, _i|
      spaces = ' ' * num
      p arr.join(spaces).center(50)
      num -= 2
    end
  end

  def insert(node, root = @tree[0])
   if root.left_node == nil && node < root.value
    pos = @tree.index(root)
    puts "pos ||| #{pos}"
    return @tree[pos].left_node = Node.new(node)
   elsif root.right_node == nil && node > root.value
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

  def delete(node, root = @tree[0])
    if node == root.value 
      pos = @tree.index(root)
      puts "pos return ||| #{pos}"
      return delete_children(@tree[pos], pos)
    end
     puts "root ||| #{root.value}"
     puts "root left #{root.left_node}" 
     puts "root right #{root.right_node}"
     puts "node ||| #{node}"
     if node < root.value
      delete(node, root.left_node)  
     elsif node > root.value
      delete(node, root.right_node)
     elsif node == root.value
      delete(node, root)
     end
  end


  def delete_children(root, pos)
    if root.left_node == nil && root.right_node == nil
      subpos = @tree.index(root)
      puts "subpos ||| #{subpos}"
      @tree[pos].value = root.value 
      return @tree[subpos].value = "nil" 
    end
    puts "child_root |||| #{root.value}"
    puts "pos child |||| #{pos}"
    if root.right_node != nil
      delete_children(root.right_node, pos)
    elsif root.right_node != nil
      delete_children(root.right_node, pos)
    end
  end

end

tree = Tree.new
array = [4,5,24,23,56,7,21,4,32,2,3]
tree.build(array)
binding.pry
