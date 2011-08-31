require_relative "generic/tree"
require_relative "rdnode"

class RDTree < Tree

  def update_value(id, node)
    super(id, node)
    node.put_on_tree(id, self)  
  end

  def rationalize!
    not_found_link2text!
  end

  def link_node?(id)
    n = value(id)
    n.class == Link
  end

private

  class Rationalize
    def do
      
    end
  end

  def not_found_link2text!
    list_link_nodes.each do |id|
      if can_not_find_tag(id)
        modify_link2text(id)
      end
    end
  end

  def modify_link2text(id)
    linknode = value(id)
    textnode = link2text(linknode)
    update_value(id, textnode)
  end

  # NOTE: Maybe Under-Engineering.
  # id of node, tmp field are not copied but
  # this time, I decided not because I considered unnessessary.
  def link2text(linknode)
    depth = linknode.depth
    text = linknode.dest
    Text.new(depth, text)
  end

  def list_link_nodes
    mk_id2tag.keys
  end

  def can_not_find_tag(id)
    tag = mk_id2tag[id]
    ! mk_tag2id.include? tag
  end

  def mk_linkmap
    # NOTE: is this use of warn method correct?
    warn "Warning: mk_linkmap should not be used. mk_id2id instead."
    mk_id2id
  end  

  def mk_id2id
    id2tag = mk_id2tag
    tag2id = mk_tag2id
    id2id = {}
    id2tag.keys.each do |id|
      tag = id2tag[id]
      if tag2id.include?( tag)
        id2id[id] = tag2id[tag]
      end
    end
    id2id
  end

  def mk_tag2id
    tag2id = {}
    for i in 0...size
      n = value(i)
      if n.class == Tag
        tag2id[n.tag] = i
      end
    end
    tag2id
  end

  def mk_id2tag
    id2tag = {}
    for i in 0...size
      n = value(i)
      if n.class == Link  
        id2tag[i] = n.dest
      end
    end
    id2tag
  end
end

if __FILE__ == $0
end 
