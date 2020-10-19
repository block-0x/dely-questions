require './extraction.rb'
require "csv"

class Insert
  def self.merged_data_write_to_csv(material_hash, recipe_hash)
    CSV.open('./../data/sample.csv','w') do |file|
      file << ["material_name", "material_calorie", "material_sodium", "amount_to_use", "material_note"]
      material_hash.each_with_index do |material, i|
        @merged_data = material.merge(recipe_hash[i])
        material_name = @merged_data["材料名"]
        material_calorie = @merged_data["100gあたりのカロリー"]
        material_sodium = @merged_data["100gあたりの食塩相当量"]
        amount_to_use = @merged_data["2人前の使用量"]
        material_note = @merged_data["備考"]
        file << ["#{material_name}", "#{material_calorie}", "#{material_sodium}", "#{amount_to_use}", "#{material_note}"]
      end
    end
  end

  def self.to_g
    puts "start..."
    csv_data = CSV.foreach('./../data/sample.csv', headers: false) do |data|
      unless data[4].nil?
        
      end
    end
  end

end

Insert.merged_data_write_to_csv(Extraction.material_hash, Extraction.recipe_hash)
Insert.to_g
