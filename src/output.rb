#!/usr/bin/env ruby
# 値の出力

class Output

  def initialize(total_calorie_and_sodium)
    @total_calorie_sum = total_calorie_and_sodium["2人前のカロリー"]
    @total_sodium_sum = total_calorie_and_sodium["2人前の塩分"]
  end

  def run()
    output
  end

  def output()
  	puts "===================================================\n\n\s\s2人前のカロリーは#{@total_calorie_sum} kcalで塩分は#{@total_sodium_sum} gです\n\n==================================================="
  end

end
