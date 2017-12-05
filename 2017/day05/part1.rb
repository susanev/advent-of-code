# susan evans
# last edited 12/04/2017
# advent of code 2017, day 5, part 1

class Part1
	def initialize(file_name)
		@maze = []
		@steps = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@maze.push(line.to_i)
			end
			process
		end
	end

	def process
		index = 0
		while index < @maze.length
			if @maze[index] == 0
				@maze[index] = 2
				index += 1
				@steps += 1
			else
				temp = index
				index += @maze[index]
				@maze[temp] += 1
			end
			@steps += 1
		end
	end

	def output
		puts "#{@steps}"
	end
end

Part1.new("input.txt")