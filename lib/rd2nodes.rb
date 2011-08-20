require_relative "node"

# rd -> [node]
def rd2nodes(file)
  f = File.open(file, "r")
  lines = f.read.split("\n")
  nodes = lines2nodes(lines)
  f.close
  nodes
end

def lines2nodes(lines)
  xs = []
  lines.each do |line|
    xs << line2node(line)
  end
  xs 
end

# Example,
# --- aaa => Text(3, "aaa")
# -- >>bbb => Link(2, "bbb")
# - [[ccc:ddd]] => Tag(1, "ccc", "ddd")
def line2node(line)
  splits = line.split(" ")
  dashes = splits[0]
  depth = dashes.split("").size
  rest = splits[1...splits.size][0]
  if rest.start_with?(">>")
    ss = parse_link(rest)
    return Link.new(depth, ss)
  elsif rest.start_with?("[[")
    ss = parse_tag(rest)
    return Tag.new(depth, ss[0], ss[1]) 
  else
    ss = parse_text(rest)
    return Text.new(depth, ss)
  end
end

def parse_text(s)
  s
end

# NOTE: under-engineering
def parse_link(s)
  s.delete ">>" 
end

# NOTE: under-engineering
def parse_tag(s)
  ss = s.delete("[[").delete("]]")
  ss.split(":")
end

if __FILE__ == $0
    puts "nodes from .rd"
  nodes = rd2nodes("sample.rd")  
  puts nodes
end
