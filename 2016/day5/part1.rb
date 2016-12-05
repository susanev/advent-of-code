class Part1
	def initialize(file_name)

		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				frequency = setFrequency(line[/[a-z]*(-[a-z]+)*/])		
				if createCode(frequency) == line[/(?<=\[)[a-z]*/]
					@sum += line[/\d+/].to_i
				end
			end
		end
	end

	def output
		puts "the sum of the sector IDs of real rooms is #{@sum}"
	end
end

Part1.new("input.txt")