require_relative './lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

puts "Level order: #{tree.level_order}"
puts "Inorder: #{tree.inorder}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"

puts "Height: #{tree.height}"
puts "Depth: #{tree.depth(tree.find(50))}"
puts "Balanced?: #{tree.balanced?}"
