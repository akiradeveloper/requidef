require_relative "tree2dot"
require_relative "matrix2csv"
require_relative "tree2matrix"

class Tree

  def to_csv
    m = tree2matrix(self)

    # TODO: Link node write the tag it links to.
    # Maybe, let Node has ID so we can reach the parent.
    c = matrix2csv(m) do |n|
      n.to_csv
    end
    c
  end

  def to_dot
    d = tree2dot(self) do |n|
      n.to_desc
    end
    d
  end
end
