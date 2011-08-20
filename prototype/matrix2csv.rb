require_relative "matrix"

def matrix2csv(matrix, &writer)
  s = ""
  for i in 0...matrix.n_size   
    ms = []
    for j in 0...matrix.m_size
      ms[j] = writer.call matrix.get([i,j])
    end
    s += ms.join ","
    s += "\n" unless i == matrix.n_size - 1
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
