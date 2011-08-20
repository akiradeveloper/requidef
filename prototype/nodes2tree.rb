require_relative "tree"
require_relative "node"

def nodes2tree(nodes)
  nodess = depth2link(nodes)
  t = Tree.new
  nodess.each do |n|
    t.add_node(n.tmp[:id], n)
  end
  for i in 1...nodess.size
    n = nodess[i]
    from = n.tmp[:parent_id]
    to = n.tmp[:id]
    t.add_edge(from, to)
  end
  t
end

def depth2link(nodes)
  nodess = [Text.new(0, "Root")] + nodes        
  nodess.each_with_index do |n, i|
    n.tmp[:id] = i
  end
  current = [nodess[0]]
  for i in 1...nodess.size
    n = nodess[i]
    x = n.depth - 1
    n.tmp[:parent_id] = current[x].tmp[:id]
  end
  
  nodess
end

if __FILE__ == $0
  puts depth2link([Text.new(1, "akira")])
  puts nodes2tree([Text.new(1, "akira")])
end
