class Node
  def initialize(depth)
    @tmp = {}
    @depth = depth
    @tree = nil
    @id = 100
  end
  attr_reader :tmp

  def depth
    if @depth == nil
      return do_depth
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
    raise "Error can not call id=(#{x}) for this node."
  end

  def add_on_tree(idd, tree)
    tree.add_node(idd, self)
    @tree = tree
    @id = idd
    @depth = nil
  end

private
  def do_depth
    @tree.depth(id)
  end
end

class Link < Node
  def initialize(depth, dest)
    super(depth)
    @dest = dest
  end
  attr_reader :dest

  def to_s
    "(Link depth:#{@depth}, dest:#{@dest}, tmp:#{@tmp})"
  end   

  def to_desc
    ""
  end

  def to_csv
    ""
  end

  def to_rd
    "#{dashes(depth)} >>#{@dest}"
  end
end

class Tag < Node
  def initialize(depth, tag, text)
    super(depth)
    @tag = tag
    @text = text
  end
  attr_reader :tag

  def to_s
    "(Tag depth:#{depth}, tag:#{@tag}, text:#{@text}, tmp:#{@tmp})"
  end  

  def to_csv
    @text
  end

  def to_desc
    @text
  end

  def to_rd
    "#{dashes(depth)} [[#{@tag}:#{@text}]]"
  end
end


class Text < Node
  def initialize(depth, text)
    super(depth)
    @text = text
  end

  def to_s
    "(Text depth:#{depth}, text:#{@text}, tmp:#{@tmp})"
  end   

  def to_csv
    @text
  end

  def to_desc
    @text
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
end
