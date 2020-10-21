require_relative "output.rb"
# require 'logger'
# file = File.open('./../logfile.log')
# logger = Logger.new(file)
# logger << "add message"

if __FILE__ == $0
  normalization = Normalization.new(Input.material_data, Input.recipe_data)
  normalization.material_data_recipe_data_merged()
  normalization.unit_normalization_module()
  sodium_sum = normalization.sodium_intakes_sum()
  calorie_sum = normalization.calorie_intakes_sum()
  Output.output(sodium_sum, calorie_sum)
end
