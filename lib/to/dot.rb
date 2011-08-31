require_relative "../rdtree"

module To

class DOT

  def initialize(rdtree, option=nil)
    @tree = rdtree
    @elems = []
    @option = option
  end

  def translate
    @tree.rationalize! # CRAZY
    add_node_line
    add_link_line
    add_link_to_children
    describe
  end

private

  def add_node_line
    @elems = []
    @tree.keys.each do |id|
      # TODO: Fix. node? is correct
      unless @tree.link_node?(id)
        @elems << dot_node_desc(id)
      end
    end
  end

  def add_link_line
    linkmap = @tree.mk_id2id
    @tree.keys.each do |id|
      if @tree.link_node?(id)
	to = linkmap[id]
	from = parent(id)
        @elems << dot_edge_desc(from, to)
	next
      end
    end
  end

  def add_link_to_children
    @tree.keys.each do |id|
      if leaf?(id)
        next
      end
      @tree.children(id).each do |child|
        @elems << dot_edge_desc(id, child) unless link_node?(child)
      end
    end
  end

  def describe
    # NOTE: The ratio of the output figure is 1 at default.
    # I/F to change the ratio is the future work.
"""
digraph graphname {
  graph [ratio = 1]
  #{elems.join("\n  ")}
}
"""
  end

  def dot_node_desc(id)
    "v#{id} [label=\"#{@tree.value(id)}\"];" 
  end

  def dot_edge_desc(from, to)
    "v#{from} -> v#{to};"
  end
end

end # end of module To

require_relative "../from/rd"
if __FILE__ == $0
  t = From::RD.new( File.read("resources/sample.rd") ).translate
  p To::DOT.new( t ).translate
end
