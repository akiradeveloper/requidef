require_relative "generic/matrix2csv"
require_relative "generic/tree2matrix"

class Tree

  # NOTE: About Design. In current design, 
  # a link node that can not find the tag node it points to
  # is treated as text node.
  def not_found_link2text!
    list_link_nodes.each do |id|
      if can_not_find_tag(id)
        modify_link2text(id)
      end
    end
  end

  # NOTE: Crazy Design
  # Akira Hayakawa, Aug 23, 2011
  # This method must be called wherever it needs the rationalized state.
  # For exmaple, a Link node that can not find the tag in the tree should be altered to Text node.
  # But, this is innately a bad design.
  # Because of my incapable of not coming up with a good idea to solve this issue elegantly.
  # The version 2.0.2 scattered this method to to_csv and to_dot.
  # But I do not know if this is sufficient.
  # To solve this issue theoritically, embed this method into every single mutate methods of the instance mattered.
  #
  # If you embed this method, please leave comment "# CRAZY" there
  # so that you can remove after I find a better solution.
  #
  # A solution is to simplify the design that lets every paths through RDTree structure.
  # Then call rationalize only one time before it is needed, case of conversion for example.
  def rationalize!
    not_found_link2text!
  end

  def to_csv 
    rationalize! # CRAZY
    m = tree2matrix(self)

    range = [
      0...m.m_size,
      1...m.n_size]
    c = matrix2csv(m, range) do |n|
      s = nil
      if n == nil
        s = ""
      else
        s = n.to_csv
      end
      s
    end
    c
  end

private

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

  # NOTE: Performance Issue
  # The following methods call mk_xxx method
  # everytime they need the information.
  # Current version adopts lazy evaluation technique
  # to always keep the state of RDTree new.
  # 
  # Now, my consideration is this is OK.
  # Because the mk_xxx functions have complexity of O(N)
  # where N is the number of nodes in the tree.
  # Therefore, for small input, the performance will not
  # go too bad.
  #
  # If, performance is found bad,
  # first consider lazy instantiation technique.
  def list_link_nodes
    mk_id2tag.keys
  end

  def can_not_find_tag(id)
    tag = mk_id2tag[id]
    ! mk_tag2id.include? tag
  end

  def link_node?(id)
    n = value(id)
    n.class == Link
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
