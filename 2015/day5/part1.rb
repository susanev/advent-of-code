class Part1
	CONST_VOWELS = "aeiou"
	CONST_NOT_NICE = ["ab", "cd", "pq", "xy"]
	
	def initialize(file_name)
		@nice_count = 0
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
		CONST_NOT_NICE.each do |str|
			if line.include? str
				return false
			end
		end
		return true
	end

	def has3Vowels(line)
		vowel_count = 0
		line.split("").each do |letter|
			if CONST_VOWELS.include? letter
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