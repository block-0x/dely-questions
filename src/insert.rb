require_relative "input_json.rb"

class Normalization

  def initialize(material_data, recipe_data)
    @material_data = material_data
    @recipe_data = recipe_data
    @merged_data = []
    @normalized_amount_arrey = []
  end

  def material_data_recipe_data_merged()
    @material_data.each_with_index do |material, i|
      @merged_hash = material.merge(@recipe_data[i])
      @merged_data.push(@merged_hash)
    end
  end

  def unit_normalization_module()
    @merged_data.each do |data|
      @two_use = data["2人前の使用量"]
      @note = data["備考"]
      nil? || pinch? || pack? || l_spoon? || s_spoon?
      @normalized_amount_arrey.push(@normalized_amount)
    end
  end

  def sodium_sum()
    sodium_sum = 0
    @merged_data.each_with_index do |merged_data, i|
      sodium_into_100g = merged_data["100gあたりの食塩相当量"].to_f
      sodium_intakes = sodium_into_100g * @normalized_amount_arrey[i] * 0.01
      sodium_sum += sodium_intakes
    end
    sodium_sum
  end

  def calorie_sum()
    calorie_sum = 0
    @merged_data.each_with_index do |merged_data, i|
      calorie_in_100g = merged_data["100gあたりのカロリー"].to_f
      calorie_intakes = calorie_in_100g * @normalized_amount_arrey[i] * 0.01
      calorie_sum += calorie_intakes
    end
    calorie_sum
  end

  def nil?()
    @normalized_amount = @two_use.sub(/g/, '').to_f if @note.nil?
  end

  def pinch?()
    @normalized_amount = (@note.sub('少々は', '').sub(/gとする/, '')).to_f if @two_use.include?("少々")
  end

  def pack?()
    data_regexp if @two_use.include?("パック")
  end

  def l_spoon?()
    data_regexp if @two_use.include?("大さじ")
  end

  def s_spoon?()
    data_regexp if @two_use.include?("小さじ")
  end

  def integer_or_fraction?()
    @normalized_amount = (@coefficient * @about_amount.to_f) unless fraction?
  end

  def fraction?()
    fraction_to_integer if @about_amount.include?("/")
  end

  def fraction_to_integer()
    @about_amount_to_integer = Rational(@about_amount).to_f
    @normalized_amount = (@coefficient * @about_amount_to_integer)
  end

  def data_regexp
    @about_amount = @two_use.gsub(/[^\d+\/]/, "")
    @coefficient = @note.match(/あたり(.*)/).to_s.gsub(/[^\d+\/+\.]/, "").to_f
    integer_or_fraction?
  end

end

if __FILE__ == $0
  normalization = Normalization.new(Input.material_data, Input.recipe_data)
  normalization.material_data_recipe_data_merged()
  normalization.unit_normalization_module()
  sodium_sum = normalization.sodium_sum()
  calorie_sum = normalization.calorie_sum()
end
