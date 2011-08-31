require_relative "rdnodes2rdtree"
require_relative "rd2rdnodes"

class Reader

  def initialize(rd)
    @rd = rd
  end

  def translate
    RDNodes2RDTree.new(
      RD2RDNodes.new(@rd).translate
    ).translate
  end

end
