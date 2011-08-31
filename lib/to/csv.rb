require_relative "../generic/tree2matrix"
require_relative "../generic/matrix2csv"

module To

class CSV

  def initialize(rdtree, option=nil)
    @tree = rdtree
    @option = option
  end 
    
  def translate
    to_csv
  end

private

  def to_csv 
    rationalize! # CRAZY

    m = tree2matrix(@tree)

    range = [
      0...m.m_size,
      1...m.n_size]

    c = matrix2csv(m, range) do |n|
      s = ""
      unless n == nil 
        s = Writer.new(n).translate
      end
      s
    end
    c
  end
 
  class Writer

    def initialize(n)
      @node = n
    end
    
    def translate
      case @node.class
      when Text
        return @node.text
      when Tag
        return @node.text
      when Link
        # Try
        return @tree.size
      end
    end
  end

end

end # end of module To
