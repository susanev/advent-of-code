class Part1
	def initialize(file_name)
		@two = 0
		@three = 0
		@lines = []
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				countEval(count(line.split("")))
			end
		end
	end

	def count(line)
		letters = "abcdefghijklmnopqrstuvwxyz".split("")
		counts = {}
		line.each do |letter|
			if counts[letter]
				counts[letter] += 1
			else
				counts[letter] = 1
			end
		end
		return counts
	end

	def countEval(counts)
		if counts.has_value?(2)
			@two += 1
		end
		if counts.has_value?(3)
			@three += 1
		end
	end

	def output
		puts "#{@two * @three}"
	end
end

Part1.new("input.txt")