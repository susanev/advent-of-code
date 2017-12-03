class Part1
	def initialize(file_name)
		@steps = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				process(line.to_i)
			end
		end
	end

	def process(num)
		width = Math.sqrt(num).ceil
		@steps = (width / 2 - (width * width - num)).abs + width / 2
		if (width * width % 2 == 0)
			@steps -= 1
		end
	end

	def output
		puts "#{@steps}"
	end
end

Part1.new("input.txt")