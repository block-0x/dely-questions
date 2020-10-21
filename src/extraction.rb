require "json"

class Input
  def self.material_hash
    material_json_path = "./../data/material.json"
    File.open(material_json_path) do |j|
      @material_hash = JSON.load(j)
    end
  end

  def self.recipe_hash
    recipe_json_path = "./../data/recipe.json"
    File.open(recipe_json_path) do |j|
      @recipe_hash = JSON.load(j)
    end
  end
end

# Input.material_hash
# Input.recipe_hash
# Input.merged_data
