require './extraction.rb'
require "csv"
# require "mathn"
# include Math

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
      # unless data[4].empty?
        if data[3].include?("パック")
          num = data[3].sub("パック", "").to_i
          regular = data[4].sub(/1パックあたり/, '').sub(/g/, '')
          puts portion = regular * num
        elsif data[3].include?("少々")
          puts portion = data[4].sub('少々は', '').sub(/gとする/, '')
        elsif data[3].include?("大さじ")
          num = data[3].sub("大さじ", "").to_i
          regular = data[4].sub(/大さじ1あたり/, '').sub(/g/, '')
          puts portion = regular * num
        elsif data[3].include?("小さじ1")
        # arrey
          # puts num = data[3].gsub(/[^\d+\/]/, "").sub("/", ',').split(/,/, 1)
          # puts num_eval = eval("{#{num}}")
        # not arrey
          num = data[3].gsub(/[^\d+\/]/, "")
          num_w = Rational(num).to_f
          regular = data[4].sub(/小さじ1あたり/, '').sub(/g/, '').to_i
          puts portion = regular * num_w
        end
      # end
    end
  end
  def pack
  end
end

Insert.merged_data_write_to_csv(Extraction.material_hash, Extraction.recipe_hash)
Insert.to_g
