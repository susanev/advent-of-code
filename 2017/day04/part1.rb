# susan evans
# last edited 12/03/2017
# advent of code 2017, day 4, part 1

class Part1
	def initialize(file_name)
		@valid = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				words = line.split(" ")
				if words.length == words.uniq.length
					@valid += 1
				end
			end
		end
	end

	def output
		puts "#{@valid}"
	end
end

Part1.new("input.txt")