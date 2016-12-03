class Part2
	def initialize(file_name)
		@count = 0
		@lines = []
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lines.push(line.split(" ").map(& :to_i))
				if @lines.length == 3
					3.times do |i|
						validTriangle(@lines[0][i], @lines[1][i], @lines[2][i])
					end
					@lines = []
				end
			end
		end
	end

	def validTriangle(num1, num2, num3)
		if num1 + num2 > num3 && num1 + num3 > num2 && num2 + num3 > num1
			@count+=1
		end
	end

	def output
		puts "#{@count} possible triangles"
	end
end

Part2.new("input.txt")