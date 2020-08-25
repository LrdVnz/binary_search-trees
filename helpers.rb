#frozen_string_literal: true
#module for making the tree class smaller. Putting methods here
module Helpers
      def delete_method(node, root = @tree[0])
        return root if root.nil?
        if node < root.value 
          root.left = delete_method(node, root.left)
        elsif node > root.value
          root.right = delete_method(node, root.right)
        else
          if root.left.nil?
            temp = root.right 
            root = nil 
            return temp 
          elsif root.right.nil? 
            temp = root.left 
            root = nil 
            return temp 
          end
          temp = min_value_node(root.right)
          root.value = temp.value 
          root.right = delete_method(temp.value, root.right)
        end
      root
      end


  def insert_method(node, root = @tree[0])
    if root.nil?
      root = Node.new(value)
    else 
      if node < root.value
        if root.left.nil?
           root.left = Node.new(node)
        else
          insert_method(node, root.left)
        end
      else
        if root.right.nil?
          root.right = Node.new(node)
        else
          insert_method(node, root.right)
        end
      end
    end
  end

  def min_value_node( node)
    current = node 
    while(current.left != nil) 
     current = current.left 
    end
    return current
 end

 def delete_node(node, root = @tree[0])
  if root == nil 
    return root 
  end
  if node < root.value 
    root.left = delete_node(node, root.left)
  elsif node > root.value 
    root.right = delete_node(node, root.right)
  else
    if root.left == nil
      temp = root.right 
      root = nil
      return temp 
    elsif root.right == nil 
      temp = root.left 
      root = nil 
      return temp 
    end
    temp = min_value_node(root.right)
    root.value = temp.value 
    root.right = delete_node(temp.value, root.right)
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
        @all_levels
      end
    
      #my attempt at printing the tree
      def print_tree
        num = 9
        @all_levels.each do |arr|
          spaces = ' ' * num
          p arr.join(spaces).center(50)
          num -= 2
        end
      end
    
      #method taken from The Odin Project
      def pretty_print(node = @tree[0], prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
      end
    
      def balanced_method(node = @tree[0], num = 0, levels = [])
        if node.nil?
          levels << num
          num = 0
          if levels.length >= 2
            levels.sort!
            @isbalanced = false if (levels[-1] - levels[-2]) > 1 || (levels[-1] - levels[-2]) < 0
          end
          return levels
       end
    
        balanced_method(node.right, num + 1, levels)
        balanced_method(node.left, num + 1, levels)
      end

end
