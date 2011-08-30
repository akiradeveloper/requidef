require_relative "rdnode"

def rd2lines(rd)
  all_lines = rd.split("\n")
  all_lines
  .delete_if do |line|
    line.empty?
  end
  .delete_if do |line|
    line.start_with? "//"
  end 
end

def rd2rdnodes( rd)
  lines = rd2lines(rd)
  nodes = lines2nodes(lines)
  nodes 
end

# rd -> [node]
def rd2nodes(rd)
  rd2rdnodes(rd)
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
# -- >bbb => Link(2, "bbb")
# - #ccc=ddd => Tag(1, "ccc", "ddd")
def line2node(line)
  splits = line.split(" ")
  dashes = splits[0]
  depth = dashes.split("").size
  rest = splits[1...splits.size].join " "
  if rest.start_with?(">")
    ss = parse_link(rest)
    return Link.new(depth, ss)
  elsif rest.start_with?("#")
    ss = parse_tag(rest)
    return Tag.new(depth, ss[0], ss[1]) 
  else
    ss = parse_text(rest)
    return Text.new(depth, ss)
  end
end

# NOTE: Under Engineering
def parse_link(s)
  # Fix: Delete only the first >> 
  s.delete(">").strip
end

# NOTE: Under Engineering
def parse_tag(s)
  ss = s.delete("#")
  # Expecting no # is used either as tagname and as text itself.
  xs = ss.split("=")
  unless xs.size == 2
    raise
  end
  [ xs[0].strip, xs[1].strip ]
end

def parse_text(s)
  s.strip
end

if __FILE__ == $0
  puts "nodes from .rd"
  nodes = rd2nodes( File.read("resources/sample.rd") )  
  puts nodes
end
