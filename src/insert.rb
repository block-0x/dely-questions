require_relative "input_json.rb"

class Normalization
  attr_accessor :material_data, :recipe_data

  def initialize(material_data, recipe_data)
    @material_data = material_data
    @recipe_data = recipe_data
  end

  def material_data_recipe_data_merged()
  	@merged_data = []
    @material_data.each_with_index do |material, i|
      @merged_hash = material.merge(@recipe_data[i])
      @merged_data.push(@merged_hash)
    end
  end

  def unit_normalization_module()
  	@portions = []
    @merged_data.each do |merged_data|
      @two_use = merged_data["2人前の使用量"]
      @note = merged_data["備考"]
      unless @note.nil?
        if pack || pinch || l_spoon || s_spoon ;end
      else
        @portion = @two_use.sub(/g/, '').to_f
      end
      @portions.push(@portion)
    end
  end

  def pack()
    about = "パック"
    if @two_use.include?(about)
      integer_or_rational?
    end
  end

  def integer_or_rational?()
    @about_amount = @two_use.gsub(/[^\d+\/]/, "")
    @normalization_num = @note.match(/あたり(.*)/).to_s.gsub(/[^\d+\/]/, "").to_f
    if rational?()
    else
      @portion = (@normalization_num * @about_amount.to_f)
    end
  end

  def pinch()
    about = "少々"
    if @two_use.include?(about)
      @portion = (@note.sub('少々は', '').sub(/gとする/, '')).to_f
    end
  end

  def l_spoon()
    about = "大さじ"
    if @two_use.include?(about)
      about_amount = @two_use.gsub(/[^\d+\/]/, "")
      about_amount = @two_use.sub("大さじ", "").to_f
      normalization_num = @note.sub(/大さじ1あたり/, '').sub(/g/, '').to_f
      @portion = (normalization_num * about_amount)
    end
  end

  def s_spoon()
    if @two_use.include?("小さじ1")
      about_amount = @two_use.gsub(/[^\d+\/]/, "")
      about_amount_to_float = Rational(about_amount).to_f
      normalization_num = @note.sub(/小さじ1あたり/, '').sub(/g/, '').to_f
      @portion = normalization_num * about_amount_to_float
    end
  end

  def rational?()
    if @about_amount.include?("/")
      @about_amount_to_float = Rational(@about_amount).to_f
      @portion = (@normalization_num * @about_amount_to_float)
    end
  end

  def sodium_intakes_sum()
    sodium_sum = 0
    @merged_data.each_with_index do |merged_data, i|
      sodium_in_100g = merged_data["100gあたりの食塩相当量"].to_f
      sodium_intakes = sodium_in_100g * @portions[i] * 0.01
      sodium_sum += sodium_intakes
    end
    sodium_sum
  end

  def calorie_intakes_sum()
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
  normalization = Normalization.new(Input.material_data, Input.recipe_data)
  normalization.material_data_recipe_data_merged()
  normalization.unit_normalization_module()
  sodium_sum = normalization.sodium_intakes_sum()
  calorie_sum = normalization.calorie_intakes_sum()
end
