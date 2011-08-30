require_relative "matrix"
require_relative "row_of_nodes"

def tree2matrix(tree)
  rows = row_of_nodes(tree)
  m = Matrix.new
  tree.keys.each do |id|
    m.set( [rows[id], tree.depth(id)], tree.value(id) )
  end
  m 
end

if __FILE__ == $0
  t = Tree.new
  t.add_node("a", "a")
  t.add_node(1, 1)
  t.add_node(2, 2)
  t.add_node(3, 3) 
  t.add_node(4, 4)

  t.add_edge("a", 2)
  t.add_edge("a", 1)
  t.add_edge(1, 3)
  t.add_edge(1, 4)

  # TODO: Move to RSpec
  # Result
  # [["a", 2, nil], [nil, 1, 3], [nil, nil, 4]]
  print tree2matrix(t)
end
