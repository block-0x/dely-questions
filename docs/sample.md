{"材料名"=>"もやし", "100gあたりのカロリー"=>14.0, "100gあたりの食塩相当量"=>0.0, "2人前の使用量"=>"100g"}

{"材料名"=>"豆苗", "100gあたりのカロリー"=>27.0, "100gあたりの食塩相当量"=>0.0, "備考"=>"1パックあたり100g", "2人前の使用量"=>"1パック"}

{"材料名"=>"豚バラ肉", "100gあたりのカロリー"=>395.0, "100gあたりの食塩相当量"=>0.1, "2人前の使用量"=>"150g"}

{"材料名"=>"塩こしょう", "100gあたりのカロリー"=>116.0, "100gあたりの食塩相当量"=>66.0, "備考"=>"少々は0.5gとする", "2人前の使用量"=>"少々"}

{"材料名"=>"しょうゆ", "100gあたりのカロリー"=>71.0, "100gあたりの食塩相当量"=>14.5, "備考"=>"大さじ1あたり18.0g", "2人前の使用量"=>"大さじ1"}

{"材料名"=>"鶏ガラスープの素", "100gあたりのカロリー"=>211.0, "100gあたりの食塩相当量"=>47.5, "備考"=>"小さじ1あたり2g", "2人前の使用量"=>"小さじ1/2"}

{"材料名"=>"白いりごま", "100gあたりのカロリー"=>599.0, "100gあたりの食塩相当量"=>0.0, "備考"=>"大さじ1あたり9g", "2人前の使用量"=>"大さじ1"}

{"材料名"=>"ラー油", "100gあたりのカロリー"=>919.0, "100gあたりの食塩相当量"=>0.0, "備考"=>"小さじ1あたり4g", "2人前の使用量"=>"小さじ1/2"
}


大さじ1あたり18.0g
大さじ1
小さじ1あたり2g
小さじ1/2
大さじ1あたり9g
大さじ1
小さじ1あたり4g
小さじ1/2

1
0
1
12
1
12


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
      unless data[4].empty?
        if data[3].include?("パック")
          puts num = data[3].gsub(/[^\d]/, "").to_i
          puts regular = data[4].sub(/1パックあたり/, '').sub(/g/, '')
          puts portion = regular * num
        elsif data[3].include?("少々")
          puts num = data[3].gsub(/[^\d]/, "").to_i
          puts regular = data[4].sub(/少々/, '').sub(/g/, '')
          puts portion = regular * num
        elsif data[3].include?("大さじ")
          puts num = data[3].gsub(/[^\d]/, "").to_i
          puts regular = data[4].sub(/大さじ/, '').sub(/g/, '')
          puts portion = regular * num
        elsif data[3].include?("小さじ")
          puts num = data[3].gsub(/[^\d]/, "").to_i
          puts regular = data[4].sub(/小さじ/, '').sub(/g/, '')
          puts portion = regular * num
        end
      end
    end
  end
end

Insert.merged_data_write_to_csv(Extraction.material_hash, Extraction.recipe_hash)
Insert.to_g
