class Node
  def initialize(depth)
    @depth = depth
    @tmp = {}
  end
  attr_reader :tmp ,:depth
  attr_accessor :id
end

class Link < Node
  def initialize(depth, dest)
    super(depth)
    @dest = dest
  end

  def to_s
    "Link depth:#{@depth}, dest:#{@dest}, tmp:#{@tmp}"
  end   

  def to_desc
    ""
  end

  def to_csv
    ""
  end
end

class Tag < Node
  def initialize(depth, tag, text)
    super(depth)
    @tag = tag
    @text = text
  end

  def to_s
    "Tag depth:#{@depth}, tag:#{@tag}, text:#{@text}, tmp:#{@tmp}"
  end  

  def to_csv
    @text
  end

  def to_desc
    @text
  end
end

class Text < Node
  def initialize(depth, text)
    super(depth)
    @text = text
  end

  def to_s
    "Text depth:#{@depth}, text:#{@text}, tmp:#{@tmp}"
  end   

  def to_csv
    @text
  end

  def to_desc
    @text
  end
end

if __FILE__ == $0
  n = Text.new(10, "akira")
  n.tmp[:x] = 100
  p n
end
