require "json"

class Extraction
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

Extraction.material_hash
Extraction.recipe_hash
# Extraction.merged_data
