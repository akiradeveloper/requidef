# NOTE:
# HTML from XMind 3.2.1 lets only h1, h2 and h3.
# So, this code only succeeds if the height of the tree is no more greater than 3.
# No practical. Must reconsider.

require "hpricot"

def html2rd(html)
  body = read_body(html)
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

def read_body(html)
  doc = Hpricot(open("sample.html"))
  x = ""
  (doc/"body").each do |e|
    x += e.to_html
  end
  x
end

if __FILE__ == $0
  p html2rd("sample.html")
  # p read_body("sample.html")
  # p read_anchor("<a name=\"hoge\">text</a>")
end
