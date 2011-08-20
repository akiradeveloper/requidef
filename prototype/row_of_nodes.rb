def row_of_nodes(tree)
  for i in 0...tree.size
    tree.value(i).tmp[:row_array] = [0, 0]   
  end
  n = tree.root_id
  set_row_of_nodes(n, tree)
  xs = []
  return xs
end

def set_row_of_nodes(id, tree)
  if tree.leaf? id
    tree.value(id).
  for c in tree.children(id)  
    set_row_of_nodes(c, tree)
     
  end
end
