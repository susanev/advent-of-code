# susan evans
# last edited 12/03/2017
# advent of code 2017, day 4, part 2

class Part2
	def initialize(file_name)
		@alpha = "abcdefghijklmnopqrstuvwxyz"
		@valid = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				words = line.split(" ")
				valid = 0
				valid_words = []
				words.each do |word|
					count = count_letters(word)
					if valid_words.index(count).nil?
						valid_words.push(count)
						valid += 1
					else
						break
					end
				end
				if valid == words.length
					@valid += 1
				end
			end
		end
	end

	def count_letters(word)
		counts = Array.new(26, 0)
		word.split("").each do |letter|
			counts[@alpha.index(letter)] += 1
		end
		return counts.join
	end

	def output
		puts "#{@valid}"
	end
end

Part2.new("input.txt")