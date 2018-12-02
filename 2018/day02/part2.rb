class Part2
	def initialize(file_name)
		@lines = []
		processFile(file_name)
		output(exactlyOne)
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lines.push(line.strip.split("").map(&:ord))
			end
		end
	end

	def exactlyOne
		for i in 0...@lines.length do
  			for j in (i+1)...@lines.length do
				sums = []
				curr = 0
				@lines[i].each do |letter|
					sums[curr] = letter - @lines[j][curr]
					curr += 1
				end

				if sums.count(0) == @lines[i].length - 1
					return (@lines[i] & @lines[j]).map(&:chr).join
				end
  			end
		end
	end

	def output(ans)
		puts "#{ans}"
	end
end

Part2.new("input.txt")