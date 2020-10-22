require_relative "input_json.rb"

class Normalization

  def initialize(input_hash)
    @material_data = input_hash[:material_data]
    @recipe_data = input_hash[:recipe_data]
    @merged_data = []
    @normalized_amount_data = []
    @key = [:merged_data, :normalized_amount_data]
    @value = []
  end

  def run()
    @value << material_data_recipe_data_merged << unit_normalization_module
    [@key, @value].transpose.to_h
  end

  def material_data_recipe_data_merged()
    @material_data.each_with_index do |material, i|
      @merged_hash = material.merge(@recipe_data[i])
      @merged_data.push(@merged_hash)
    end
    @merged_data
  end

  def unit_normalization_module()
    @merged_data.each do |data|
      @two_use = data["2人前の使用量"]
      @note = data["備考"]
      nil? || pinch? || pack? || l_spoon? || s_spoon?
      @normalized_amount_data.push(@normalized_amount)
    end
    @normalized_amount_data
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
  input = Input.new
  input.material_data
  input.recipe_data
  normalization = Normalization.new(input.material_data, input.recipe_data)
  normalization.material_data_recipe_data_merged()
  normalization.unit_normalization_module()
  sodium_sum = normalization.sodium_sum()
  calorie_sum = normalization.calorie_sum()
end
