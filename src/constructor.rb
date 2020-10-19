require "./extraction.rb"
require 'active_support'
require 'active_support/core_ext'

class Constructor
	def self.output(material_hash, recipe_hash)
	recipe_hash.each do |recipe|
		target_name = recipe["材料名"]
		target_quantity = recipe["2人前の使用量"]
		# puts target
		# puts material_hash.select {|k, v| v == target }
		material_hash.each do |material|
			puts material_target_name = material.detect {|k, v| v == target_name }
			puts material_target_quantity = material.detect {|k, v| v == target_quantity }
			# puts target_name
			# puts target_name
			# puts material["100gあたりのカロリー"]
			# puts material["100gあたりの食塩相当量"]
			# puts material["100gあたりの食塩相当量"]
		end
		# material_hash.each do |material|
		#   # puts matersial
		#   pumaterial_name = material.detect {|k, v| v == target_name }
		#   puts material.detect {|k, v| v == target_quantity }
		# end
	end
	# target = material_hash[0]["材料名"]
	# targeted = recipe_json.["#{target}"]
	# p "recipe"
	# puts targeted
	end
end

Constructor.output(Extraction.material_json, Extraction.recipe_json)
