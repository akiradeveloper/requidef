$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "requidef"
require "optparse"

# Main 
opt = OptionParser.new

usage = nil
opt.on("--usage") do |v|
  usage = v
end

to = nil
opt.on("--to=ToType") do |v| 
  to = v
end

from = nil
opt.on("--from=FromType") do |v|
  from = v
end

opt.on("--parse-lenient", "parse all text nodes as link nodes.") do |v|
  # NOTE: Design Issue
  # This uses global env table. If Ruby process has its own table, use it instead.
  ENV["REQUIDEF_PARSE_LENIENT"] = "true"
end

opt.parse!(ARGV)

def usage_msg
"""  
Usage:
requidef supports translations from one file format to another one.
You usually first create standard input and pipe it to requidef command and continue piping.

Clear Example,
cat input.mm | requidef --from=mm --to=rd | requidef --from=rd --to=dot > output.dot
"""
end

if usage
  print usage_msg
  exit
end

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
