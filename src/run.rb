require_relative "output.rb"
# require 'logger'
# file = File.open('./../logfile.log')
# logger = Logger.new(file)
# logger << "add message"

if __FILE__ == $0
  input = Input.new
  material_data = input.material_data
  recipe_data = input.recipe_data
  normalization = Normalization.new(material_data, recipe_data)
  merged_data = normalization.material_data_recipe_data_merged
  normalized_amount_data = normalization.unit_normalization_module
  sum = Sum.new(merged_data, normalized_amount_data)
  total_calorie_and_sodium = sum.run
  output = Output.new(total_calorie_and_sodium)
  output.output
end
