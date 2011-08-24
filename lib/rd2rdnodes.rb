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

def parse_lenient?
  ENV["REQUIDEF_PARSE_LENIENT"] == "true"
end

# Example,
# --- aaa => Text(3, "aaa")
# -- >>bbb => Link(2, "bbb")
# - [[ccc:ddd]] => Tag(1, "ccc", "ddd")
def line2node(line)
  splits = line.split(" ")
  dashes = splits[0]
  depth = dashes.split("").size
  rest = splits[1...splits.size].join " "
  if rest.start_with?(">>")
    ss = parse_link(rest)
    return Link.new(depth, ss)
  elsif rest.start_with?("[[")
    ss = parse_tag(rest)
    return Tag.new(depth, ss[0], ss[1]) 
  else
    # NOTE: Design Issue
    # If REQUIDEF_PARSE_LENIENT flag is on,
    # This software understands every text nodes as link nodes whose dest is text.
    if parse_lenient?
      ss = parse_text(rest)
      return Link.new(depth, ss)
    end
    ss = parse_text(rest)
    return Text.new(depth, ss)
  end
end

# NOTE: Under Engineering
def parse_link(s)
  # Fix: Delete only the first >> 
  s.delete ">>" 
end

# NOTE: Under Engineering
def parse_tag(s)
  ss = s.delete("[[").delete("]]")
  # Fix: What happen if having two colons
  # In current version, if haveing two colons will cause unexpected output or runtime error.
  xs = ss.split(":")
  case xs.size
  when 1
    return [xs[0], xs[0]]
  when 2
    return xs
  end
  # In current  version, if more than two colons will raise exception.
  raise "Parse Erorr. The line #{s} contains more than two colons"
end

def parse_text(s)
  s
end

if __FILE__ == $0
  puts "nodes from .rd"
  nodes = rd2nodes( File.read("sample.rd") )  
  puts nodes
end
