class Tree
  def to_rd
    nodes = list_depth_traverse(root_id).delete(rood_id) 
    nodes.map do |node|
      value(node).to_rd
    end.join("\n")
  end
end
