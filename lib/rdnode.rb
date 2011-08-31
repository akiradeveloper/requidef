class Node

  def initialize(depth)
    @tmp = {}
    @depth = depth
    @tree = nil
    
    # NOTE: What is this magic number 100?
    # I guess for some debugging and turned it to nil.
    # @id = 100 
    @id # = nil 
  end

  attr_reader :tmp

#  def to_s
#    "depth:#{depth}, id:#{id}, tree:#{tree}, tmp:#{tmp}"
#  end

  def of_type?(type)
    self.class == type
  end

  def depth
    if @depth == nil
      return get_depth_asking_tree
    end
    @depth
  end

  def id
    @id
  end

  def id=(x)
    if @tree == nil
      @id = x
      return
    end
    raise "Error can not call tree=(#{@tree}), id=(#{x}) for this node."
  end

  # Never call explicitly
  def put_on_tree(idd, tree)
    @tree = tree
    @id = idd # Sync ID
    @depth = nil
  end

private
  def get_depth_asking_tree
    @tree.depth(@id)
  end
end

class Link < Node

  def initialize(depth, dest)
    super(depth)
    @dest = dest
  end
  attr_reader :dest

  def to_rd
    "#{dashes(depth)} >#{@dest}"
  end
end

class Tag < Node

  def initialize(depth, tag, text)
    super(depth)
    @tag = tag
    @text = text
  end
  attr_reader :tag

  def to_rd
    "#{dashes(depth)} \##{@tag} = #{@text}"
  end
end


class Text < Node
  def initialize(depth, text)
    super(depth)
    @text = text
  end

  def to_rd
    "#{dashes(depth)} #{@text}"
  end
end

def dashes(n)
  Array.new(n, "-").join ""
end

DummyRoot = Text.new(0, "DummyRoot")

if __FILE__ == $0
  n = Text.new(10, "akira")
  n.tmp[:x] = 100
  p n
  n.id = 100
  p n.id

  p n.of_type?(Text)
end
