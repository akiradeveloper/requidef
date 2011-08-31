class MultiMap

  def initialize
    @map = {}
  end

  def []=(key, value)
    unless @map.include? key
      @map[key] = []
    end
    @map[key] << value
  end

  def [](key)
    @map[key]
  end  

  def keys
    @map.keys
  end
end

if __FILE__ == $0
  m = MultiMap.new
  m["k"] = "v1"
  m["k"] = "v2"

  p m.keys
  p m["k"]
end
