require_relative "generic/tree"
require_relative "rdnode"

def nodes2tree(nodes)
  nodess = depth2link(nodes)
  t = Tree.new
  nodess.each do |n|
    t.add_node(n.id, n)
  end
  for i in 1...nodess.size
    n = nodess[i]
    from = n.tmp[:parent_id]
    to = n.id
    t.add_edge(from, to)
  end
  t
end

def depth2link(nodes)
  nodess = [DummyRoot] + nodes        
  nodess.each_with_index do |n, i|
    n.id = i
  end
  current = [nodess[0]]
  for i in 1...nodess.size
    n = nodess[i]
    x = n.depth - 1
    n.tmp[:parent_id] = current[x].id
    current[n.depth] = n
  end
  
  nodess
end

if __FILE__ == $0
  puts depth2link([Text.new(1, "akira"), Text.new(2, "developer")])
  t = nodes2tree([Text.new(1, "akira"), Text.new(2, "developer")])

  puts "------------"
  puts t.size
end
