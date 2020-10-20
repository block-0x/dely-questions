require "./extraction"
require "csv"

class Insert
  def self.merged_data_write_to_csv(material_hash, recipe_hash)
  	@merged_hash = []
    CSV.open('./../data/sample.csv','w') do |file|
      # file << ["name", "material_calorie", "material_sodium", "amount_to_use", "material_note"]
      material_hash.each_with_index do |material, i|
        @merged_data = material.merge(recipe_hash[i])
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
        # arrey
          # num = amount_to_use.gsub(/[^\d+\/]/, "").sub("/", ',').split(/,/, 1)
          # num_eval = eval("{#{num}}")
        # not arrey
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

  def self.sodium_intake_sum(material_hash)
  	# material_hash.each_with_index do |material, i|
    #  p @portions.map{|item| item * 2}
    #  @portions.zip(point).map{|n,p| n*p}.sum
    @sodium_intake_sum = 0
    @merged_hash.each_with_index do |merged_hash, i|
      sodium_in_100g = merged_hash["100gあたりの食塩相当量"].to_f
      sodium_intake = sodium_in_100g * @portions[i] * 0.01
      @sodium_intake_sum += sodium_intake
    end
    p @sodium_intake_sum
  end

  def self.calorie_intake_sum(material_hash)
    @calorie_intake_sum = 0
    @merged_hash.each_with_index do |merged_hash, i|
      calorie_in_100g = merged_hash["100gあたりのカロリー"].to_f
      calorie_intake = calorie_in_100g * @portions[i] * 0.01
      @calorie_intake_sum += calorie_intake
    end
    p @calorie_intake_sum
  end
end

Insert.merged_data_write_to_csv(Extraction.material_hash, Extraction.recipe_hash)
Insert.unit_normalization
Insert.sodium_intake_sum(Extraction.material_hash)
Insert.calorie_intake_sum(Extraction.material_hash)

