require_relative "input_json.rb"
require "csv"

class Insert
  def self.merged_data_write_to_csv(material_data, recipe_data)
  	@merged_hash = []
    CSV.open('./../data/sample.csv','w') do |file|
      material_data.each_with_index do |material, i|
        @merged_data = material.merge(recipe_data[i])
        name = @merged_data["材料名"]
        material_calorie = @merged_data["100gあたりのカロリー"]
        material_sodium = @merged_data["100gあたりの食塩相当量"]
        amount_to_use = @merged_data["2人前の使用量"]
        material_note = @merged_data["備考"]
        file << ["#{name}", "#{material_calorie}", "#{material_sodium}", "#{amount_to_use}", "#{material_note}"]
        @merged_hash.push(@merged_data)
      end
    end
  end

  def self.unit_normalization
  	@portions = []
    material_csv_data = CSV.foreach('./../data/sample.csv', headers: false) do |data|
      amount_to_use = data[3]
      material_note = data[4]
      unless material_note.empty?
        if amount_to_use.include?("パック")
          num = amount_to_use.sub("パック", "").to_f
          regular = material_note.sub(/1パックあたり/, '').sub(/g/, '')
          @portion = (regular * num).to_f
        elsif amount_to_use.include?("少々")
          @portion = (material_note.sub('少々は', '').sub(/gとする/, '')).to_f
        elsif amount_to_use.include?("大さじ")
          num = amount_to_use.sub("大さじ", "").to_f
          regular = material_note.sub(/大さじ1あたり/, '').sub(/g/, '')
          @portion = (regular * num).to_f
        elsif amount_to_use.include?("小さじ1")
          num = amount_to_use.gsub(/[^\d+\/]/, "")
          num_w = Rational(num).to_f
          regular = data[4].sub(/小さじ1あたり/, '').sub(/g/, '').to_f
          @portion = regular * num_w
        end
      else
        @portion = amount_to_use.sub(/g/, '').to_f
      end
      @portions.push(@portion)
    end
  end

  def self.sodium_intakes_sum(material_data)
    sodium_sum = 0
    @merged_hash.each_with_index do |merged_hash, i|
      sodium_in_100g = merged_hash["100gあたりの食塩相当量"].to_f
      sodium_intakes = sodium_in_100g * @portions[i] * 0.01
      sodium_sum += sodium_intakes
    end
    sodium_sum
  end

  def self.calorie_intakes_sum(material_data)
    calorie_sum = 0
    @merged_hash.each_with_index do |merged_hash, i|
      calorie_in_100g = merged_hash["100gあたりのカロリー"].to_f
      calorie_intakes = calorie_in_100g * @portions[i] * 0.01
      calorie_sum += calorie_intakes
    end
    calorie_sum
  end
end

if __FILE__ == $0
  Insert.merged_data_write_to_csv(Extraction.material_data, Extraction.recipe_data)
  Insert.unit_normalization
  Insert.sodium_intake_sum(Extraction.material_data)
  Insert.calorie_intake_sum(Extraction.material_data)
end
