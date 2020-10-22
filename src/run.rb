require_relative "output.rb"
# require 'logger'
# file = File.open('./../logfile.log')
# logger = Logger.new(file)
# logger << "add message"

if __FILE__ == $0
  input = Input.new()
  normalization = Normalization.new(input.run)
  sum = Sum.new(normalization.run)
  output = Output.new(sum.run)
  output.run
end
