require_relative "output.rb"


Insert.merged_data_write_to_csv(Input.material_hash, Input.recipe_hash)
Insert.unit_normalization
sodium_sum = Insert.sodium_intakes_sum(Input.material_hash)
calorie_sum = Insert.calorie_intakes_sum(Input.material_hash)
Output.output(sodium_sum, calorie_sum)
