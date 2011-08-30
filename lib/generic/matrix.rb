class Matrix

  def initialize()
    @mat = []
    @n = 0
  end

  def n_size
    @n
  end

  def m_size
    @mat.size
  end

  def set(at, value)
    expand(at)
    i = at[0]
    j = at[1]
    @mat[i][j] = value
  end
  
  def get(at)
    i = at[0]
    j = at[1]
    @mat[i][j]
  end

  def to_s
    p @mat
#    print "["
#    print @mat.join(",\n")
#    print "]\n"
  end

private 

  def expand(by)
    _m_size = by[0] + 1
    _n_size = by[1] + 1

    if _m_size > m_size
      expand_m(_m_size)
    end

    if _n_size > n_size
      expand_n(_n_size)
    end

  end

  def expand_m(to)
    (to-m_size).times do
      @mat << Array.new(n_size)
    end
  end

  def expand_n(to)
    @mat.each do |x|
      n = x.size
      (to-n).times do
        x << nil
      end
    end
    @n = to
  end
end

if __FILE__ == $0
  m = Matrix.new
  m.set([0,2], "akira")
  puts m
  m.set([2,0], "developer")
  puts m
end
