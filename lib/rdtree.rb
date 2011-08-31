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
    def get_dest_id(id)
      tag = @tree.value(id).tag
      id = @tag_id[tag] 
      raise ArgumentError unless id.size == 1
      return id
    end

    def has_dest?(id)
      
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

    def list_link_nodes_with_no_dest
      return list_link_nodes.delete_if do |id|
        has_dest?( id )
      end
    end

    def no_ambigous_tag?
      @tag_id.keys.each do |tag|
        values = @tag_id[tag]
	return false if values.size > 1
      end
    end

    def all_link_nodes_dest_found?
      dests_cands = @tag_id.keys
      @link_nodes.each do |id|
        dest = @tree.value(id)
	return false unless dests_cands.include?( dest )
      end
    end
  end # end of class Statistic

private

  class Rationalize
    def initialize(rdtree)
      @tree = rdtree
    end
    
    def run!
      stat = @tree.get_statistic
      if stat.all_link_nodes_dest_found?
        return 
      end
      stat.list_link_nodes_with_no_dest.each do |id|
        n = @tree.value(id)
        @tree.update_value( id, textnode(n) )
      end
    end
  private
    def textnode(linknode)
      Text.new( 
        linknode.depth,
	"! " + linknode.dest )
    end
  end
end

require_relative "from/rd"
if __FILE__ == $0
  t = From::RD.new( File.read("resources/sample.rd") ).translate  
  
  p t.get_statistic
end 

