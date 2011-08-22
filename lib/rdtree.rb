require_relative "generic/matrix2csv"
require_relative "generic/tree2matrix"
require_relative "rdtree2dot"

class Tree

  def to_csv 
    m = tree2matrix(self)

    range = [
      0...m.m_size,
      1...m.n_size]
    c = matrix2csv(m, range) do |n|
      s = nil
      if n == nil
        s = ""
      else
        s = n.to_csv
      end
      s
    end
    c
  end
end

require_relative "rd2rdtree"
if __FILE__ == $0
  t = rd2rdtree( File.read("sample.rd"))
  puts t.to_csv
  puts t.to_dot
end
