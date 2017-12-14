# susan evans
# last edited 12/12/2017
# advent of code 2017, day 13, part 1

#85558

class Part1
	def initialize(file_name)
		@pos = 0
		@severity = 0
		@layers = []
		processFile(file_name)
		incr
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				depth = line[/\d+/].to_i
				range = line[line.index(":") + 2, line.length].to_i
				@layers.push({depth: depth, range: range, pos: 0, dir: 1})
			end
		end
	end

	def incr
		@severity = 0
		98.times do
			at_zero
			@pos += 1
			@layers.each do |layer|
				if layer[:pos] + layer[:dir] == layer[:range] ||
						layer[:pos] + layer[:dir] == -1
					layer[:dir] *= -1
				end
				layer[:pos] = layer[:pos] + layer[:dir]
			end
		end
	end

	def at_zero
		@layers.each do |layer|
			if @pos == layer[:depth] && layer[:pos] == 0
				@severity += layer[:depth] * layer[:range]
			end
		end
	end

	def output
		puts "#{@severity}"
	end
end

Part1.new("input.txt")
