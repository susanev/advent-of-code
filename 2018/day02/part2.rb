# susan evans
# last edited 12/02/2018
# advent of code 2018, day 2, part 2

class Part2
	def initialize(file_name)
		@lines = []
		processFile(file_name)
		@length = @lines[0].length - 1
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
  				if @lines[i].map.with_index { |val, k| val - @lines[j][k] }
  						.count(0) == @length
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