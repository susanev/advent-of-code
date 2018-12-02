class Part1
	def initialize(file_name)
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		@sum = File.open(file_name, "r").
				readlines.map(&:to_i).reduce(:+)
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
