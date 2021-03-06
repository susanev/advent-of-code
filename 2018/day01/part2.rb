# susan evans
# last edited 12/01/2018
# advent of code 2018, day 1, part 2

class Part2
	def initialize(file_name)
		@lines = []
		@answers = {}
		processFile(file_name)
		@dup = findDup
		output
	end

	def processFile(file_name)
		@lines = File.open(file_name, "r").readlines.map(&:to_i)
	end

	def findDup
		answers_index = 0
		sum = 0
		while @dup == nil
			sum += @lines[answers_index]
			if @answers[sum]
				return sum
			else
				@answers[sum] = true
				answers_index = (answers_index + 1) % @lines.length
			end
		end
	end

	def output
		puts "#{@dup}"
	end
end

Part2.new("input.txt")
