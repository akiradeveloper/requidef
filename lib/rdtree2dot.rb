require_relative "generic/tree"

class Tree

  def to_dot
    elems = []
    for i in 0...size
      unless link_node?(i)
        elems << dot_node_desc(i)
      end
    end
    linkmap = mk_linkmap
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

  def link_node?(id)
    n = value(id)
    n.class == Link
  end

  def mk_tag2id
    tag2id = {}
    for i in 0...size
      n = value(i)
      if n.class == Tag
        tag2id[n.tag] = i
      end
    end
    tag2id
  end

  def mk_linkmap
    id2tag = {}
    for i in 0...size
      n = value(i)
      if n.class == Link  
        id2tag[i] = n.dest
      end
    end
    id2id = {}
    tag2id = mk_tag2id
    id2tag.keys.each do |key|
      tag = id2tag[key]
      id2id[key] = tag2id[tag]
    end
    id2id
  end
end