# susan evans
# last edited 12/12/2017
# advent of code 2017, day 13, part 1

#85558

class Part1
	def initialize(file_name)
		@severity = 0
		@layers = []
		processFile(file_name)
		calc
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				create_range(line[/\d+/].to_i,
							line[line.index(":") + 2, line.length].to_i)
			end
		end
	end

	def create_range(depth, range)
		range_arr = []
		range.times do |n|
			range_arr.push(n)
		end
		(range - 2).downto(1).each do |n|
			range_arr.push(n)
		end
		@layers[depth] = range_arr
	end

	def calc
		@layers.each_with_index do |layer, index|
			if !layer.nil? && layer[index % layer.length] == 0
				@severity += index * (layer[layer.length / 2] + 1)
			end
		end
	end

	def output
		puts "severity: #{@severity}"
	end
end

Part1.new("input.txt")
