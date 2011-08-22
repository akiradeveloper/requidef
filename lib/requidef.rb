require_relative "rdtree"
require_relative "rd2rdnodes"
require_relative "rdnodes2rdtree"

def rd2tree(file)
  nodes2tree( rd2nodes(file) )
end

# File -> String
def dot(file)
  rd2tree(file).to_dot
end

# File -> String
def csv(file)
  rd2tree(file).to_csv
end
