# susan evans
# last edited 12/13/2017
# advent of code 2017, day 13, part 2

class Part2
	def initialize(file_name)
		@delay = 0
		@layers = []
		processFile(file_name)
		find
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

	def find
		while !is_zero
			@delay += 1
		end
	end

	def is_zero
		@layers.each_with_index do |layer, index|
			if !layer.nil? && layer[(index + @delay) % layer.length] == 0
				return false
			end
		end
		return true
	end

	def output
		puts "delay: #{@delay}"
	end
end

Part2.new("input.txt")
