class Part1
	def initialize(file_name)
		@count = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				validTriangle(line.chomp.split(" ").map(& :to_i))
			end
		end
	end

	def validTriangle(sides)
		max = sides.max
		if sides.reduce(:+) - max > max
			@count += 1
		end
	end

	def output
		puts "#{@count} possible triangles"
	end
end

Part1.new("input.txt")