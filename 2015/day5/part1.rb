class Part1
	def initialize(file_name)
		@nice_count = 0
		@vowels = "aeiou"
		@not_nice = ["ab", "cd", "pq", "xy"]
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if isNice(line) && has3Vowels(line) && hasDoubles(line)
					@nice_count += 1
				end
			end
		end
	end

	def isNice(line)
		@not_nice.each do |str|
			if line.include? str
				return false
			end
		end
		return true
	end

	def has3Vowels(line)
		vowel_count = 0
		line.split("").each do |letter|
			if @vowels.include? letter
				vowel_count += 1
			end
		end
		return vowel_count >= 3
	end

	def hasDoubles(line)
		line.length.times do |index|
			if line[index] == line[index + 1]
				return true
			end
		end
		return false
	end

	def output
		puts "there are #{@nice_count} nice strings"
	end
end

Part1.new("input.txt")