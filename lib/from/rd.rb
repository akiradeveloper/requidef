require_relative "rdnodes2rdtree"
require_relative "rd2rdnodes"

module From

class RD

  def initialize(rd)
    @rd = rd
  end

  def translate
    RDNodes2RDTree.new(
      RD2RDNodes.new(@rd).translate
    ).translate
  end

end

end # end of module From

if __FILE__ == $0
  t = From::RD.new( File.read("resources/sample.rd") ).translate
  p t
end
