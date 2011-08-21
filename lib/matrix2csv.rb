require_relative "matrix"

def matrix2csv(matrix, &writer)
  s = ""
  for i in 0...matrix.m_size   
    ms = []
    for j in 0...matrix.n_size
      ms[j] = writer.call matrix.get([i,j])
    end
    # NOTE: The separator of csv file is decisively |
    # I/F to change the charactor is the future work.
    separator = "|"
    s += ms.join separator
    s += "\n" unless i == matrix.m_size - 1
  end
  s
end

if __FILE__ == $0
  m = Matrix.new
  m.set([0,1], "a")
  m.set([1,0], "b")

  t = matrix2csv(m) do |x|
    s = nil
    if x == nil
      s = "" 
    else
      s = x*2
    end
    s
  end
  print t 
end 
