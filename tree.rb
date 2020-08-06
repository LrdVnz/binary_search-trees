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

  def update_tree
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

  def delete(node, root = @tree[0])
    if node == root.value
      pos = @tree.index(root)
      puts "pos return ||| #{pos}"
      if !@tree[pos].right_node.nil?
       return delete_with_children(@tree[pos].right_node, pos)
      elsif !@tree[pos].right_node.nil?
       return delete_with_children(@tree[pos], pos)
      end
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

  private


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
      puts 'output ||||'
      puts @output.to_s
      end
    puts "output||||| #{@output.join(' ')}"
    @output
  end

  def delete_with_children(root, pos)
    if root.left_node.nil?
      subpos = @tree.index(root)
      puts "subpos ||| #{subpos}"
      @tree[pos].value = root.value
      if root.right_node.nil?
      return @tree[subpos].value = 'nil'
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

  

  def queue_is_empty?(array)
    is_empty = true
    array.each { |e| is_empty = false if e != 'nil' }
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
    @all_levels.each_with_index do |arr, _i|
      spaces = ' ' * num
      p arr.join(spaces).center(50)
      num -= 2
    end
  end

end

tree = Tree.new
array = [4, 5, 24, 23, 56, 7, 21, 4, 32, 2, 3]
tree.build(array)
binding.pry
