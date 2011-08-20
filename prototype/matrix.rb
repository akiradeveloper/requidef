class Matrix
  def initialize()
    @mat = []
    @m = 0
  end

  def m_size
    @m
  end

  def n_size
    @mat.size
  end

  def set(at, value)
    expand(at)
    n = at[0]
    m = at[1]
    @mat[n][m] = value
  end
  
  def get(at)
    n = at[0]
    m = at[1]
    @mat[n][m]
  end

  def to_s
    p @mat
#    print "["
#    print @mat.join(",\n")
#    print "]\n"
  end

private 

  def expand(by)
    _n_size = by[0] + 1
    _m_size = by[1] + 1

    if _m_size > m_size
      expand_m(_m_size)
    end

    if _n_size > n_size
      expand_n(_n_size)
    end
  end

  def expand_n(to)
    (to-n_size).times do
      @mat << Array.new(m_size)
    end
  end

  def expand_m(to)
    @mat.each do |x|
      m = x.size
      (to-m).times do
        x << nil
      end
    end
    @m = to
  end
end

if __FILE__ == $0
  m = Matrix.new
  m.set([0,2], "akira")
  puts m
  m.set([2,0], "developer")
  puts m
end
