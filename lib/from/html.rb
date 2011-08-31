# NOTE:
# HTML from XMind 3.2.1 lets only h1, h2 and h3.
# So, this code only succeeds if the height of the tree is no more greater than 3.
# No practical. Must reconsider.

require "hpricot"

module From

class HTML

  def initialize(html, option=nil)
    @html = html
    @option = option 
  end

  def translate
    html2rd
  end

private

  def html2rd
    body = read_body
    regex = /<h(\d).*?>(.*?)<\/h\d>/m
    body.scan(regex).map do |e|
      hx2rd(e)
    end.join("\n")
  end
  
  def hx2rd(header)
    depth = header[0].to_i
    s = read_anchor(header[1].strip)
    "#{repeat(depth, "-")} #{s}"
  end
  
  def read_anchor(anchor)
    anchor.scan(/<a.*?>(.*?)<\/a>/m)[0][0]
  end
  
  def repeat(n, s)
    Array.new(n, s).join
  end
  
  def read_body
    doc = Hpricot( @html )
    x = ""
    (doc/"body").each do |e|
      x += e.to_html
    end
    x
  end

end

end


if __FILE__ == $0
  o = From::HTML.new( File.read("resources/sample.html") )
  p o.translate
end
