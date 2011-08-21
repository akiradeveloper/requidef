$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "requidef"
require "optparse"

def print_dot(input)
  print dot(input)
end

def print_csv(input)
  print csv(input)
end

# Main 
opt = OptionParser.new

type = nil
opt.on("-t VAL") do |v| 
  type = v
end

input = nil
opt.on("-f VAL") do |v|
  input = v
end
opt.parse!(ARGV)

case type 
when "dot"
  print_dot(input)
when "csv"
  print_csv(input)
else
  raise "no match on type"
end
