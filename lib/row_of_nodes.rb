require_relative "tree"

def row_of_nodes(tree)
  RowOfNodes.new(tree).row_of_nodes
end

class RowOfNodes

  def initialize(tree)
    @tree = tree
    @array = Array.new(tree.values.size, [0,0])
  end 

  def row_of_nodes
    n = @tree.root_id
    set_row_of_nodes(n)
    @array.map { |xx| xx[0] }
  end

private

  def set_row_of_nodes(id)
    if @tree.leaf? id
      @array[id][1] = 1
      return 
    end
  
    children_id = @tree.children(id)
       
    for i in 0...children_id.size
      child_id = children_id[i]
      a = @array[id][0] + @array[id][1]
      # @array[child_id][0] = @array[id][0] + @array[id][1]
      @array[child_id] = [a, @array[child_id][1]]
      set_row_of_nodes(child_id)
      # @array[id][1] += @array[child_id][1]
      b = @array[id][1] + @array[child_id][1]
      @array[id] = [@array[id][0], b]
    end
  end
end

if __FILE__ == $0
  # test ------------------
  a = [[1,1], [2,2]]
  a[0][0] = a[0][0] + a[0][1]
  p a #=> no problem.

  # NOTE: 
  # The problem occured above related to
  # Array on recursion.
  # -----------------------

  t = Tree.new
  t.add_node(0, nil)
  t.add_node(1, nil)
  t.add_node(2, nil)
  t.add_node(3, nil)
  t.add_node(4, nil)

  t.add_edge(0, 2)
  t.add_edge(0, 1)
  t.add_edge(1, 3)
  t.add_edge(1, 4)

  p row_of_nodes(t)
end
