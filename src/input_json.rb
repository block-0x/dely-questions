require 'json'

class Input

  def initialize()
    @material_json_path = "./../data/material.json"
    @recipe_json_path = "./../data/recipe.json"
  end

  def material_data()
    File.open(@material_json_path) { |j| JSON.load(j) }
  end

  def recipe_data()
    File.open(@recipe_json_path) { |j| JSON.load(j) }
  end

end

if __FILE__ == $0
  input = Input.new
  p input.material_data
  p input.recipe_data
end
