require_relative "rdtree"
require_relative "rd2rdnodes"
require_relative "rdnodes2rdtree"
require_relative "html2rd"
require_relative "mm2rdtree"
require_relative "rdtree2rd"
require_relative "option"

# File -> String
def to_dot(txt)
  rd2rdtree( txt ).to_dot
end

# File -> String
def to_csv(txt)
  rd2rdtree( txt ).to_csv
end

def to_rd(txt, ext)
  case ext
  when "mm"
    return mm2rd(txt)
  when "html"
    return html2rd(txt)
  else
    raise "the input stream assumed type can not translate into rd."
  end
end

def mm2rd(txt)
  rdtree2rd( mm2rdtree(txt))
end
