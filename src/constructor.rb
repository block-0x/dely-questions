require_relative "extraction.rb"

class Constructor
  def self.output(material_hash, recipe_hash)
  	recipe_hash.each do |recipe|
  	  puts recipe
      target_name = recipe["材料名"]
      target_quantity = recipe["2人前の使用量"]
      # puts target
      # puts material_hash.select {|k, v| v == target }
      material_hash.each do |material|
        # puts matersial
        pumaterial_name = material.detect {|k, v| v == target_name }
        puts material.detect {|k, v| v == target_quantity }
      end
    end
    # target = material_hash[0]["材料名"]
    # targeted = recipe_json.["#{target}"]
    # p "recipe"
    # puts targeted
  end
end

Constructor.output(Extraction.material_json, Extraction.recipe_json)
