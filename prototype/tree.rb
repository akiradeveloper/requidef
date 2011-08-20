class Tree
  def initialize
    @values = []
    @edges = []
    @parents = []
  end
  def size
    @values.size
  end
  def root_id
    0
  end
  
  def value(id)
    @values[id]
  end
  def children(id)
    @edges[id]
  end
  
  def add_node(id, value)
    @values[id] = value 
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
  t.add_node(0, "a")
  t.add_node(1, "b")
  t.add_node(2, "c")
  
  t.add_edge(0, 1)
  t.add_edge(1, 2)
  [0,1,2].each do |i|
    puts "id:#{i}"
    puts "value:#{t.value(i)}"
    puts "leaf?:#{t.leaf?(i)}"
    puts "branch?:#{t.branch?(i)}"
  end
  [0,1].each do |i|
    puts "children:#{t.children(i)}"
  end
end


