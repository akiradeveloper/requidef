require_relative "tree"

def row_of_nodes(tree)
  RowOfNodes.new(tree).row_of_nodes
end

class RowOfNodes

  def initialize(tree)
    @tree = tree
    @array = initmap(tree)
  end 



  def row_of_nodes
    n = @tree.root_id
    set_row_of_nodes(n)
    # @array.map { |xx| xx[0] }
    h = {}
    @array.each_pair do |key, value|
      h[key] = value[0]
    end
    h
  end

private

  def initmap(tree)
    h = {}
    tree.keys.each do |id|
      h[id] = [0,0]
    end
    return h
  end

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
  # For Tree to let any as ID.
  # This test must be passed.
  t.add_node("a", nil)
  t.add_node("b", nil)
  t.add_node(2, nil)
  t.add_node(3, nil)
  t.add_node(4, nil)

  t.add_edge("a", 2)
  t.add_edge("a", "b")
  t.add_edge("b", 3)
  t.add_edge("b", 4)

  # TODO: Move to RSpec
  # Result.
  # {"a"=>0, "b"=>1, 2=>0, 3=>1, 4=>2}
  p row_of_nodes(t)
end
