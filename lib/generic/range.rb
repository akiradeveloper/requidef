def str2range(s)
  xs = s.split ".."
  raise "range parse error." if xs.size > 2
  from = xs[0].strip.to_i
  to = xs[1].strip.to_i
  Range.new(from, to)
end

class String
  def to_range
    str2range(self)
  end
end

if __FILE__ == $0
  str2range("1..10").each do |i|
    print i, " " 
  end
  print "\n"
end
