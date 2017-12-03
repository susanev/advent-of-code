class Part2
	def initialize(file_name)
		@nice_count = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if hasPair(line) && hasRepeat(line)
					@nice_count += 1
				end
			end
		end
	end

	def hasPair(line)
		line.length.times do |index|
			check = line[index..index + 1]
			new_line = line[index + 2..line.length]
			if !new_line.nil? && new_line.include?(check)
				return true
			end
		end
		return false
	end

	def hasRepeat(line)
		line.split("").each_with_index do |letter, index|
			if letter == line[index + 2]
				return true
			end
		end
		return false
	end

	def output
		puts "there are #{@nice_count} nice strings"
	end
end

Part2.new("input.txt")