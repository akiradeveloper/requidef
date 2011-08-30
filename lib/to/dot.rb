require_relative "../generic/tree"

class DOT
  def initialize(rdtree)
  end

  def write
  end
end

class Tree

  def to_dot
    rationalize! # CRAZY
    elems = []
    for i in 0...size
      unless link_node?(i)
        elems << dot_node_desc(i)
      end
    end
    linkmap = mk_id2id
    for i in 0...size
      if link_node?(i)
	to = linkmap[i]
	from = parent(i)
        elems << dot_edge_desc(from, to)
	next
      end
      if leaf?(i)
        next
      end
      children(i).each do |child|
        elems << dot_edge_desc(i, child) unless link_node?(child)
      end
    end
    
    # NOTE: The ratio of the output figure is 1 at default.
    # I/F to change the ratio is the future work.
"""
digraph graphname {
  graph [ratio = 1]
  #{elems.join("\n  ")}
}
"""
  end

private
  def dot_node_desc(id)
    "v#{id} [label=\"#{value(id).to_desc}\"];" 
  end

  def dot_edge_desc(from, to)
    "v#{from} -> v#{to};"
  end
end
