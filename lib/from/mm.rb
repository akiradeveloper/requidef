require "rexml/document"
require_relative "../rdtree"

module From

class MM

  def initialize(mm, option=nil)
    @mm = mm
    @option = option
  end

  def translate
    build_tree
  end

private

  # Doc -> Tree (of Text node class)
  def build_tree
    t = RDTree.new
    t.add_node(0, DummyRoot)
    root = root_node_of
    t.add_edge(0, root.attributes["ID"])
    do_build_tree(root, 1, t) 
    t
  end
  
  def do_build_tree(doc, depth, t)
    id = doc.attributes["ID"]
    t.add_node( id, to_node(doc, depth) )
  
    doc.elements.each("arrowlink") do |link|
      # TODO: Implement 
      # t.add_edge( id, child_id )
    end  
  
    doc.elements.each("node") do |child_doc|
      child_depth = depth + 1
      child_id = child_doc.attributes["ID"]
      child_value = to_node( child_doc, child_depth )
      t.add_node( child_id, child_value )
      t.add_edge( id, child_id )
  
      do_build_tree( child_doc, child_depth, t )
    end
  end
  
  def to_node(doc, depth)
    text = doc.attributes["TEXT"]
    tag = doc.attributes["ID"]
    Tag.new(depth, tag, text)
  end
  
  def root_node_of
    doc = REXML::Document.new( @mm )
    xs = []
    doc.root.elements.each("node") do |node| 
      xs << node
    end
    raise "Invalid mm file." unless xs.size == 1
    xs[0]
  end
end

end # end of module From


if __FILE__ == $0
  p From::MM.new( File.read("resources/sample.mm") ).translate

  puts "# Test ------------------------"
  include REXML
  f = File.open("resources/sample.mm", "r")
  txt = f.read

  p txt
  doc = Drcument.new txt
  p doc
  p doc.size
  p "xx"
  p doc.root.size
  p doc.root.elements.size
  p doc.root.elements[1]
  p doc.root.elements[2]
  p doc.root.elements[3]

  n = doc.root.elements[1]
  p n.attributes["TEXT"]

  f.close

  # Try:
  # doc.size # what means?
  # doc.root #=> Element
  # doc.root.
  # n.attributes[name]
  
  puts "# -----------------------------"
end
