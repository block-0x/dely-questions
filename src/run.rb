require_relative "output.rb"
# require 'logger'
# file = File.open('./../logfile.log')
# logger = Logger.new(file)
# logger << "add message"

if __FILE__ == $0
  Insert.material_data_recipe_data_merged(Input.material_data, Input.recipe_data)
  Insert.unit_normalization
  sodium_sum = Insert.sodium_intakes_sum(Input.material_data)
  calorie_sum = Insert.calorie_intakes_sum(Input.material_data)
  Output.output(sodium_sum, calorie_sum)
end
