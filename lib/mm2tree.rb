require "rexml/document"
require_relative "tree"
require_relative "node"

def mm2tree(mm)
  build_tree(mm)
end

# Doc -> Tree (of Text node class)
def build_tree(mm)
  t = Tree.new
  doc_root_id = 1
  t.add_node(0, DummyRoot)
  t.add_edge(0, doc_root_id)
  do_build_tree(root_node_of(mm), doc_root_id, 1, t) 
  t
end

def do_build_tree(doc, id, depth, t)
  t.add_node( id, to_node(doc, depth) )
  n = doc.elements.size
  for i in 1...n+1
    child_id = id+i
    child_depth = depth + 1
    child_doc = doc.elements[i]
    child_value = to_node( child_doc, child_depth )
    t.add_node( child_id, child_value )
    t.add_edge( id, child_id )

    do_build_tree( child_doc, child_id, child_depth, t )
  end
end

def to_node(doc, depth)
  text = doc.attributes["TEXT"]
  Text.new(depth, text)
end

def root_node_of(mm)
  f = File.open(mm, "r")
  
  txt = f.read
  doc = REXML::Document.new( txt )

  f.close
  doc.root.elements[1]
end

if __FILE__ == $0
  # p root_node_of("sample.mm")
  p mm2tree("sample.mm")

  puts "# Test ------------------------"
  include REXML
  f = File.open("sample.mm", "r")
  txt = f.read

  p txt
  doc = Document.new txt
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
