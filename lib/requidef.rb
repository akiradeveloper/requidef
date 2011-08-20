require_relative "nodetree"
require_relative "rd2nodes"
require_relative "nodes2tree"

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
