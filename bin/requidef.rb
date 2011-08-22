$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "requidef"
require "optparse"

# Main 
opt = OptionParser.new

to = nil
opt.on("--to=ToType") do |v| 
  to = v
end

from = nil
opt.on("--from=[FromType]") do |v|
  from = v
end

opt.parse!(ARGV)

inp = STDIN.read

def check_nil(x)
  if x == nil
    raise "input #{x} is nil"
  end
  x
end

case to 
when "dot"
  print to_dot(inp)
when "csv"
  print to_csv(inp)
when "rd"
  print to_rd(inp, check_nil(from))
else
  raise "no match on output type"
end
