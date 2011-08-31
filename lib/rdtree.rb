require_relative "generic/tree"
require_relative "generic/multimap"
require_relative "rdnode"

class RDTree < Tree

  def update_value(id, node)
    super(id, node)
    node.put_on_tree(id, self)  
  end

  def rationalize!
    Rationalize.new(self).run!
  end

  # use value(id).of_type?(Link) instead
  def link_node?(id)
    n = value(id)
    n.of_type?(Link)
  end

  def get_statistic
    Statistic.new(self)
  end

  class Statistic

    def initialize(rdtree)
      @tree = rdtree

      @text_nodes = []
      @link_nodes = []
      @tag_id = MultiMap.new

      @tree.keys.each do |id|
        visit(id)
      end
    end

  private
    def visit(id)
      n = @tree.value(id)
      if n.of_type?( Text )
        @text_nodes << id
	return
      
      elsif n.of_type?( Link )
        @link_nodes << id
	return 

      elsif n.of_type?( Tag )
        @tag_id[n.tag] = id
	return
    
      else
        raise ArgumentError
      end
    end         
   
  public
    def get_dest_node(id)
      tag = @tree.value(id).tag
      id = @tag_id[tag] 
      raise ArgumentError unless id.size == 1
      return id
    end

    def list_tag_nodes
      @tag_id.keys
    end

    def list_link_nodes
      @link_nodes
    end

    def list_text_nodes
      @text_nodes
    end

    def no_ambigous_tag?
      @tag_id.keys.each do |tag|
        values = @tag_id[tag]
	return false if values.size > 1
      end
    end

    def all_linknode_dest_found?
      dests_cands = @tag_id.keys
      @list_nodes.each do |id|
        dest = @tree.value(id)
	return false unless dests_cands.includes?( dest )
      end
    end
  end

private

  class Rationalize
    def initialize(rdtree)
      @tree = rdtree
    end
    
    def run!
      stat = @tree.get_statistic
      if stat.all_linknodes_dest_found?
        return 
      end
      stat.list_linknode_with_no_dest.each do |id|
        n = @tree.value(id)
        @tree.update( id, textnode(n) )
      end
    end
  private
    def textnode(linknode)
      Text.new( 
        linknode.depth,
	"! " + linknode.dest )
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
end

require_relative "from/rd"
if __FILE__ == $0
  t = From::RD.new( File.read("resources/sample.rd") ).translate  
  
  p t.get_statistic
end 

