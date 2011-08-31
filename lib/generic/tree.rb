class Tree

  def initialize
    @values = {}
    @edges = {}
    @parents = {}
    @root = nil
  end

  def list_breadth_traverse(under)
    list = [under]
    queue = [under]
    until queue.empty? 
      id = deque(queue)
      children(id).each do |child|
	list << child
        queue << child
      end
    end
    return list
  end

  def list_depth_traverse(under)
    list = []
    do_list_depth_traverse(under, list)
    return list
  end

  # TODO: Should be removed.
  # Commented out
#  def values
#    @values.values
#  end

  def size
    @values.size
  end

  def parent(id)
    @parents[id]
  end

  def depth(id)
    d = 0
    i = id
    until( i==root_id )
      i = parent(i)
      d += 1
    end
    d
  end

  def keys
    @values.keys
  end

  def root_id
    @root
  end
  
  def value(id)
    @values[id]
  end

  def children(id)
    edges = @edges[id]
    if edges == nil
      return []
    end
    edges
  end
  
  def add_node(id, value)
    # The first node added is the root node.
    @root = id if @root == nil
    @values[id] = value 
  end

  def update_value(id, value)
    # In current version, 
    # update_value is just a wrapper of add_node.
    # but in the future version, this may need modification.
    add_node(id, value)
  end

  def add_edge(from, to)
    register_edge(from, to)
    register_parent(to, from)
  end

  def leaf?(id)
    @edges[id] == nil
  end

  def branch?(id)
    ! leaf?(id)
  end

private

  def deque(queue)
    queue.delete_at(0)
  end

  def do_list_depth_traverse(under, list)
    list << under
    if leaf?(under)
      return
    end
    children(under).each do |id|
      do_list_depth_traverse(id, list)
    end
  end

  def register_edge(from, to)
    if @edges[from] == nil
      @edges[from] = Array.new
    end
    @edges[from] << to
  end
  
  def register_parent(from, to)
    @parents[from] = to  
  end
end

if __FILE__ == $0
  t = Tree.new
  t.add_edge(0, 1)

  t.add_node(0, "a")
  t.add_node(1, "b")
  t.add_node(2, "c")
  
  t.add_edge(1, 2)
  [0,1,2].each do |i|
    puts "id:#{i}"
    puts "value:#{t.value(i)}"
    puts "leaf?:#{t.leaf?(i)}"
    puts "branch?:#{t.branch?(i)}"
    puts "depth:#{t.depth(i)}"
  end
  [0,1].each do |i|
    puts "children:#{t.children(i)}"
  end

  p t.list_depth_traverse(t.root_id)
  p t.list_breadth_traverse(t.root_id)
end
