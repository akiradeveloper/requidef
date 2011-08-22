require_relative "generic/tree"

def rdtree2rd(tree)
  tree.to_rd
end

class Tree
  def to_rd
    nodes = list_depth_traverse(root_id)
    # NOTE: Eliminate the DummyRoot from rd file.
    nodes.delete(root_id) 
    nodes.map do |node|
      value(node).to_rd
    end.join("\n")
  end
end

require_relative "rd2rdtree"
if __FILE__ == $0
  t = rd2rdtree( File.read("sample.rd"))
  print t.to_rd
end
