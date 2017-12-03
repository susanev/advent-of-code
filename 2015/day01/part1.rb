class Part1
	def initialize(file_name)
		@floor = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@floor = line.split("").map { |i| i == '(' ? 1 : -1 }.reduce(:+)
			end
		end
	end

	def output
		puts "floor #{@floor}"
	end
end

Part1.new("input.txt")