# susan evans
# last edited 12/10/2016
# advent of code 2015, day 8, part 2
# calculates total length of encoded strings in file
# and the number of characters in the string literal
# and prints the difference

class Part2
	def initialize(file_name)
		@total = 0
		@encoded = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				@total += line.length
				# +4 accounts for special case of surrounding quotes
				@encoded += line.length + 4
				# parameter is line with surrounding quotes removed
				count_encoded(line[1,line.length - 2])
			end
		end
	end

	def count_encoded(str)
		pos = 0
		while pos < str.length
			if str[pos] == "\"" || str[pos] == "\\"
				@encoded += 1
			end
			pos += 1
		end
	end
					
	def output
		puts "difference: #{@encoded - @total}"
	end
end

Part2.new("input.txt")