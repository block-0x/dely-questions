require 'json'

class Input
  def self.material_data
    material_json_path = "./../data/material.json"
    File.open(material_json_path) { |j| JSON.load(j) }
  end

  def self.recipe_data
    recipe_json_path = "./../data/recipe.json"
    File.open(recipe_json_path) { |j| JSON.load(j) }
  end
end

if __FILE__ == $0
  p Input.material_data
  p Input.recipe_data
end
