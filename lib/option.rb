class Option

  def initialize
    @map = {}
    @opt = OptionParser.new
    setup
  end

  def []=(key, value)
    @map[key] = value
  end
  
  def run(inp)
  end

private

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
  
  def setup
    @opt.on("--view-supported-translations") do |v|
      puts SUPPORTED_TRANSLATIONS_MSG
      exit
    end
    
    @opt.on("--usage") do |v|
      puts USAGE_MSG
      exit
    end

    @opt.on("--to-csv-indexing Range") do |v|
      raise  
    end
    
    @opt.on("--map-unlinked-tag-to-text") do |v|
      raise
    end
    
    @opt.on("--map-text-to-tag") do |v|
      raise
    end

    @opt.on("--map-tag-to-link-if-possible") do |v|
      raise
    end

    @opt.on("--to=ToType") do |v| 
      @map["to"] = v
    end
    
    @opt.on("--from=FromType") do |v|
      @map["from"] = v
    end
  end
  
  def type
  end

  def nil?(*keys)
    keys.each do |key|
      return false unless @map[key] == nil
    end
    return true
  end

  def run_self
  end

  def run_to
  end

  def run_from
  end

  FROM = 0
  TO = 1
  SELF = 2
  def rw
    if nil?("from", "to")
      return SELF
   
    elsif nil?("from")
      return TO
    
    else
      return FROM
    end
  end

  def validate
  end
end
