class Part1
	def initialize(file_name)
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				row = line.split(" ").map(&:to_i)
				@sum += row.max - row.min
			end
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")