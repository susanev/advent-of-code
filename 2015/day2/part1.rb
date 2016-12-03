class Part1
	def initialize(file_name)
		@paper = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				nums = line.split("x").map(& :to_i)
				min = [nums[0] * nums[1], nums[0] * nums[2], nums[1] * nums[2]].min
				@paper += 2 * nums[0] * nums[1] + 2 * nums[1] * nums[2] + 2 * nums[2] * nums[0] + min
			end
		end
	end

	def output
		puts "The elves should order #{@paper} square feet of wrapping paper"
	end
end

Part1.new("input.txt")