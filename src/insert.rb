require_relative "input_json.rb"

class Normalization
  def self.material_data_recipe_data_merged(material, recipe)
  	@merged_data = []
    material.each_with_index do |material, i|
      @merged_hash = material.merge(recipe[i])
      @merged_data.push(@merged_hash)
    end
    @merged_data
  end

  def self.unit_normalization
  	@portions = []
    @merged_data.each do |data|
      amount_to_use = data["2人前の使用量"]
      material_note = data["備考"]
      unless material_note.nil?
        aaa(amount_to_use, material_note)
        if amount_to_use.include?("パック")
          num = amount_to_use.sub("パック", "").to_f
          regular = material_note.sub(/1パックあたり/, '').sub(/g/, '')
          @portion = (regular * num).to_f
        if amount_to_use.include?("少々")
          @portion = (material_note.sub('少々は', '').sub(/gとする/, '')).to_f
        elsif amount_to_use.include?("大さじ")
          num = amount_to_use.sub("大さじ", "").to_f
          regular = material_note.sub(/大さじ1あたり/, '').sub(/g/, '')
          @portion = (regular * num).to_f
        elsif amount_to_use.include?("小さじ1")
          num = amount_to_use.gsub(/[^\d+\/]/, "")
          num_w = Rational(num).to_f
          regular = material_note.sub(/小さじ1あたり/, '').sub(/g/, '').to_f
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
    @merged_data.each_with_index do |merged_data, i|
      sodium_in_100g = merged_data["100gあたりの食塩相当量"].to_f
      sodium_intakes = sodium_in_100g * @portions[i] * 0.01
      sodium_sum += sodium_intakes
    end
    sodium_sum
  end

  def self.calorie_intakes_sum(material_data)
    calorie_sum = 0
    @merged_data.each_with_index do |merged_data, i|
      calorie_in_100g = merged_data["100gあたりのカロリー"].to_f
      calorie_intakes = calorie_in_100g * @portions[i] * 0.01
      calorie_sum += calorie_intakes
    end
    calorie_sum
  end
end

if __FILE__ == $0
  Normalization.material_data_recipe_data_merged(Extraction.material_data, Extraction.recipe_data)
  Normalization.unit_normalization
  Normalization.sodium_intake_sum(Extraction.material_data)
  Normalization.calorie_intake_sum(Extraction.material_data)
end
