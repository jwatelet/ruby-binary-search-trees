require_relative 'node'

class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    start_index = 0
    end_index = array.length - 1
    return nil if start_index > end_index

    mid_index = array.length / 2

    root = Node.new(array[mid_index])
    root.left = build_tree(array.slice(0, mid_index))
    root.right = build_tree(array.slice(mid_index + 1, mid_index))

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
