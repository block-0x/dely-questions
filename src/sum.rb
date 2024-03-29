#!/usr/bin/env ruby
# 合計値の計算

class Sum

  def initialize(normalization_hash)
    @merged_data = normalization_hash[:merged_data]
    @normalized_amount_data = normalization_hash[:normalized_amount_data]
    @sodium_sum = 0
    @calorie_sum = 0
    @key =  ["2人前のカロリー", "2人前の塩分"]
    @value = []
  end

  def run()
    @value << calorie_sum << sodium_sum
    [@key, @value].transpose.to_h
  end

  def calorie_sum()
    @merged_data
    @merged_data.each_with_index do |merged_data, i|
      calorie_in_100g = merged_data["100gあたりのカロリー"].to_f
      calorie_intakes = calorie_in_100g * @normalized_amount_data[i] * 0.01
      @calorie_sum += calorie_intakes
    end
    return @calorie_sum
  end

  def sodium_sum()
    @merged_data.each_with_index do |merged_data, i|
      sodium_into_100g = merged_data["100gあたりの食塩相当量"].to_f
      sodium_intakes = sodium_into_100g * @normalized_amount_data[i] * 0.01
      @sodium_sum += sodium_intakes
    end
    return @sodium_sum
  end

end
