class Part1
	def initialize(file_name)
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				digits = line.split("")
				digits.each_with_index do |digit, index|
					if digit == digits[(index + 1) % digits.length]
						@sum += digit.to_i
					end
				end
			end
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
