require_relative 'node'

class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid_index = array.length / 2

    root = Node.new(array[mid_index])
    root.left = build_tree(array.slice(0, mid_index))
    root.right = build_tree(array.slice(mid_index + 1, mid_index))

    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      temp = node
      node = min_value(temp.right)
      node.right = delete_min(temp.right)
      node.left = temp.left
    end
    node
  end

  def min_value(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def delete_min(node)
    return node.right if node.left.nil?

    node.left = delete_min(node.left)
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(root = @root, queue = [])
    result = block_given? ? nil : []

    queue.push(root)
    until queue.empty?
      current_node = queue.shift

      if block_given?
        yield current_node
      else
        result << current_node.data
      end

      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?

    end
    return result unless block_given?
  end

  def preorder(root = @root, stack = [])
    return if root.nil?

    if block_given?
      yield root
    else
      stack.concat([root.data])
    end

    preorder(root.left, stack) unless root.left.nil?

    preorder(root.right, stack) unless root.right.nil?
    stack
  end

  def inorder(root = @root, stack = [])
    return if root.nil?

    inorder(root.left, stack) unless root.left.nil?

    if block_given?
      yield root
    else
      stack.concat([root.data])
    end

    inorder(root.right, stack) unless root.right.nil?
    stack
  end

  def postorder(root = @root, stack = [])
    return if root.nil?

    postorder(root.left, stack) unless root.left.nil?

    postorder(root.right, stack) unless root.right.nil?

    if block_given?
      yield root
    else
      stack.concat([root.data])
    end

    stack
  end

  def height(root = @root)
    return -1 if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)

    [left_height, right_height].max + 1
  end

  def depth(node)
    return 0 if node.nil? || node == @root

    pointer = @root
    depth = 0
    until pointer.data == node.data
      pointer = if node.data < pointer.data
                  pointer.left
                else
                  pointer.right
                end
      depth += 1
    end
    depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(level_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
