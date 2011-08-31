$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "requidef"

opt = Option.new

inp = STDIN.read

print opt.run(inp)
