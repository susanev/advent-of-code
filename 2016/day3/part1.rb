class Part1
	def initialize(file_name)
		@count = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				sides = line.chomp.split(" ").map(& :to_i)
				validTriangle(sides[0], sides[1], sides[2])
			end
		end
	end

	def validTriangle(side1, side2, side3)
		if side1 + side2 > side3 && side1 + side3 > side2 && 
				side2 + side3 > side1
			@count+=1
		end
	end

	def output
		puts "#{@count} possible triangles"
	end
end

Part1.new("input.txt")