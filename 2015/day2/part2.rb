class Part2
	def initialize(file_name)
		@ribbon = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				dimensions = line.split("x").map(& :to_i)
				perm = dimensions.map { |i| i * 2 }
				@ribbon += perm.reduce(:+) - perm.max + dimensions.reduce(:*)
			end
		end
	end

	def output
		puts "The elves should order #{@ribbon} feet of ribbon"
	end
end

Part2.new("input.txt")