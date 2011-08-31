require_relative "generic/tree"

class Tree

  def fmap_unlinked_tag_to_text!
  end

  def fmap_text_to_tag!
  end

  def fmap_tag_to_link_if_possible!
  end

end
  
class Writer

  def initialize(rdtree, option)
    @tree = rdtree
    @option = option
  end

  def translate
    nodes_without_dummy.map do |node|
      @tree.value(node).to_rd
    end.join("\n")
  end

private

  def nodes_without_dummy
    @tree
    .list_depth_traverse( @tree.root_id )
    .delete_if { |x| x == @tree.root_id }
  end
end

require_relative "reader"
if __FILE__ == $0
  t = Reader.new( File.read("resources/sample.rd") ).translate
  puts Writer.new( t ).translate
end
