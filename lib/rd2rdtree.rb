require_relative "rd2rdnodes"
require_relative "rdnodes2rdtree"

def rd2rdtree( rd)
  rdnodes2rdtree( rd2rdnodes(rd) ) 
end
