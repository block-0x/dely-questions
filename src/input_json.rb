#!/usr/bin/env ruby
# 値の取得

require 'json'

class Input

  def initialize()
    @material_json_path = "./data/material.json"
    @recipe_json_path = "./data/recipe.json"
    @key = [:material_data, :recipe_data]
    @value = []
  end

  def run()
    @value << material_data << recipe_data
    Hash[@key.collect.zip(@value)]
  end

  def material_data()
    File.open(@material_json_path) { |j| JSON.load(j) }
  end

  def recipe_data()
    File.open(@recipe_json_path) { |j| JSON.load(j) }
  end

end
