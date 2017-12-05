# susan evans
# last edited 12/04/2017
# advent of code 2017, day 5, part 2

class Part2
	def initialize(file_name)
		@steps = 0
		@maze = []
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
				if @maze[temp] >= 3
					@maze[temp] -= 1
				else
					@maze[temp] += 1
				end
			end
			@steps += 1
		end
	end

	def output
		puts "#{@steps}"
	end
end

Part2.new("input.txt")