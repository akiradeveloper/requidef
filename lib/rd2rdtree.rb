require_relative "rd2rdnodes"
require_relative "rdnodes2rdtree"

def rd2rdtree(rd)
  nodes2tree( rd2nodes(rd) ) 
end
