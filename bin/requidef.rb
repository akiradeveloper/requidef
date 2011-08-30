$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "requidef"
require "optparse"

# Main 
opt = OptionParser.new

opt.on("--to-csv-indexing Range") do |v|
  raise
end

opt.on("--map-uselesstag-to-text") do |v|
  raise
end

to = nil
opt.on("--to=ToType") do |v| 
  to = v
end

from = nil
opt.on("--from=FromType") do |v|
  from = v
end

def translations
"""Supported Translations:
mm, html -> rd
rd -> dot, csv
(Future release will support rd <-> tgf).

For the usage, please see --usage
"""
end

opt.on("--view-supported-translations") do |v|
  puts translations
  exit
end

def usage_msg
"""Usage:
requidef supports translations from one file format to another one.
You usually first create standard input and pipe it to requidef command and continue piping.

Clear Example,
cat input.mm | requidef --from=mm --to=rd | requidef --from=rd --to=dot > output.dot

For more details, see help.

Enjoy!
"""
end

opt.on("--usage") do |v|
  puts usage_msg
  exit
end

opt.parse!(ARGV)

inp = STDIN.read

if from==nil

  case to 
  when "dot"
    print to_dot(inp)
  when "csv"
    print to_csv(inp)
  else
    raise "no match to type"
  end

elsif to==nil

  case from
  when "mm"
    print from_mm(inp)
  when "html"
    print from_html(inp)
  else
    raise "no match from type"
  end

else
   # RD -> RD
end
