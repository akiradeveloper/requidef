require_relative "generic/tree"
require_relative "rdnode"

class RDNodes2RDTree

  def initialize(rdnodes)
    @nodes = rdnodes
  end

  def translate
    nodes = with_link_to_parent
    t = Tree.new
    nodes.each do |n|
      n.add_on_tree(n.id, t)
    end
    for i in 1...nodes.size
      n = nodes[i]
      from = n.tmp[:parent_id]
      to = n.id
      t.add_edge(from, to)
    end
    t
  end

private

  def with_link_to_parent
    nodes = [DummyRoot] + @nodes
    nodes.each_with_index do |n, i|
      n.id = i
    end
  
    current = [nodes[0]]
    for i in 1...nodes.size
      n = nodes[i]
      x = n.depth - 1
      n.tmp[:parent_id] = current[x].id
      current[n.depth] = n
    end
    nodes
  end
end

if __FILE__ == $0
  t = RDNodes2RDTree.new([Text.new(1, "akira"), Text.new(2, "developer")]).translate
  p t

  puts "------------"
  puts t.size
end
