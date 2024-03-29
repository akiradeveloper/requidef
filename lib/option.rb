require_relative "generic/range"

class Option

  MAP_TAG_TO_LINK_IF_POSSIBLE = "map-tag-to-link-if-possible"
  MAP_TEXT_TO_TAG = "map-text-to-tag"
  MAP_UNLINKED_TAG_TO_TEXT = "map-unlinked-tag-to-text"
  TO_CSV_INDEXING = "to-csv-indexing"
  USAGE = "usage"
  VIEW_SUPPORTED_TRANSLATIONS = "view-supported-translations"

  def initialize
    @map = {}
    @opt = OptionParser.new
    setup
    ARGV.parse!
  end

  def []=(key, value)
    @map[key] = value
  end

  def [](key)
    @map[key]
  end

  def has?(key)
    # TODO: Under Engineering.
    # Use method to assert the key is not included.
    @map[key] != nil
  end
  
  # Input -> String
  def run(inp)
    case rw
    when FROM
      case type
      when "mm"
        return To::RD.new(
	  From::MM.new(inp, self).translate 
	).tranlate
      when "html"
        return From::HTML.new(inp, self).translate
      else
      end
    when TO
      rdtree = From::RD.new(inp).translate
      case type
      when "dot"
        return To::DOT.new(rdtree, self).translate
      when "csv"
        return To::CSV.new(rdtree, self).translate
      else
      end
    when SELF
      rdtree = From::RD.new(inp).translate
      return To::RD.new(rdtree, self).translate
    else
      raise ArgumentError
    end
  end

    
private

  FROM = "from"
  TO = "to"
  SELF = "self"

  def rw
    if nil?(FROM, TO)
      return SELF
   
    elsif nil?("from")
      return TO
    
    else
      return FROM
    end
  end

  def type
    case rw
    when FROM
      @map[FROM]
    when TO
      @map[TO]
    when SELF
      "rd"
    else
    end
  end

  def nil?(*keys)
    keys.each do |key|
      return false if has?(key)
    end
    return true
  end

  def setup

    @opt.on("--" + TO_CSV_INDEXING + "=Range") do |v|
      [TO_CSV_INDEXING] = str2range( v )
    end  
   
    @opt.on("--" + VIEW_SUPPORTED_TRANSLATIONS) do |v|
      puts SUPPORTED_TRANSLATIONS_MSG
      exit
    end
    
    @opt.on("--" + USAGE) do |v|
      puts USAGE_MSG
      exit
    end

    @opt.on("--" + MAP_TEXT_TO_TAG) do |v|
      [MAP_TEXT_TO_TAG] = true
    end
    
    @opt.on("--" + MAP_UNLINKED_TAG_TO_TEXT) do |v|
      [MAP_UNLINKED_TAG_TO_TEXT] = true
    end
    
    @opt.on("--" + MAP_TAG_TO_LINK_IF_POSSIBLE) do |v|
      [MAP_TAG_TO_LINK_IF_POSSIBLE] = true
    end

    @opt.on("--" + TO + "=ToType") do |v| 
      @map["to"] = v
    end
    
    @opt.on("--" + FROM + "=FromType") do |v|
      @map["from"] = v
    end
  end


SUPPORTED_TRANSLATIONS_MSG <<"EOF"
Supported Translations:
mm, html -> rd
rd -> dot, csv
(Future release will support rd <-> tgf).

For the usage, please see --usage

Enjoy!
EOF
  
USAGE_MSG <<"EOF"
Usage:
requidef supports translations from one file format to another one.
You usually first create standard input and pipe it to requidef command and continue piping.

Clear Example,
cat input.mm | requidef --from=mm --to=rd | requidef --from=rd --to=dot > output.dot
  
For more details, see help.
  
Enjoy!
EOF
  
end
