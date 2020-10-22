require_relative 'sum.rb'

class Output

  def initialize(total_calorie_and_sodium)
    @total_calorie_sum = total_calorie_and_sodium["2人前のカロリー"]
    @total_sodium_sum = total_calorie_and_sodium["2人前の塩分"]
  end

  def output()
  	puts "===================================================\n\n\s\s2人前のカロリーは#{@total_calorie_sum} kcalで塩分は#{@total_sodium_sum} gです\n\n==================================================="
  end

end

if __FILE__ == $0
  Insert.material_data_recipe_data_merged(Input.material_hash, Input.recipe_hash)
  Insert.unit_normalization
  sodium_sum = Insert.sodium_intakes_sum(Input.material_hash)
  calorie_sum = Insert.calorie_intakes_sum(Input.material_hash)
  Output.output(sodium_sum, calorie_sum)
end
