class Part2
	def initialize(file_name)
		@lines = []
		@answers = {}
		processFile(file_name)
		@dup = findDup
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			@lines = f.read.split("\n").map(&:to_i)
		end
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
			end
			answers_index = (answers_index + 1) % @lines.length
		end
	end

	def output
		puts "#{@dup}"
	end
end

Part2.new("input.txt")
