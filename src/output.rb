require_relative 'insert.rb'

class Output
  def self.output(sodium_intake_sum, calorie_intake_sum)
  	puts "===================================================\n\n\s\s2人前のカロリーは#{calorie_intake_sum} kcalで塩分は#{sodium_intake_sum} gです\n\n==================================================="
  end
end

if __FILE__ == $0
  Insert.material_data_recipe_data_merged(Input.material_hash, Input.recipe_hash)
  Insert.unit_normalization
  sodium_sum = Insert.sodium_intakes_sum(Input.material_hash)
  calorie_sum = Insert.calorie_intakes_sum(Input.material_hash)
  Output.output(sodium_sum, calorie_sum)
end
