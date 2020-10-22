require_relative "output.rb"
require_relative "log.rb"

if __FILE__ == $0
  input = Input.new()
  normalization = Normalization.new(input.run)
  sum = Sum.new(normalization.run)
  output = Output.new(sum.run)
  output.run
end
