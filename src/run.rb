#!/usr/bin/env ruby
# 値の取得 → 単位の正規化 → 合計値の計算 → 値の出力

require "./../log/log.rb"
require_relative "input_json.rb"
require_relative "normalization.rb"
require_relative 'sum.rb'
require_relative "output.rb"


if __FILE__ == $0
  input = Input.new()
  normalization = Normalization.new(input.run)
  sum = Sum.new(normalization.run)
  output = Output.new(sum.run)
  output.run
end
