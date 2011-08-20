require_relative "matrix"
require_relative "row_of_nodes"

def tree2matrix(tree)
  rows = row_of_nodes(tree)
  m = Matrix.new
  for i in 0...tree.size
    m.set( [rows[i], tree.depth(i)], tree.value(i) )
  end
  m 
end

if __FILE__ == $0
  t = Tree.new
  t.add_node(0, 0)
  t.add_node(1, 1)
  t.add_node(2, 2)
  t.add_node(3, 3) 
  t.add_node(4, 4)

  t.add_edge(0, 2)
  t.add_edge(0, 1)
  t.add_edge(1, 3)
  t.add_edge(1, 4)

  print tree2matrix(t)
end
