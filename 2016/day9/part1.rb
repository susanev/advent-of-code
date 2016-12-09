# susan evans
# last edited 12/08/2016
# advent of code 2016, day 9, part 1
# needs to be cleaned

class Part1
	def initialize(file_name)
		@length = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				count(line)
			end
		end
	end

	# counts the length
	def count(line)
		index = 0
		while (index < line.length)
			if line[index] == "("
				marker = line[index]
				index += 1
				while line[index] != ")"
					marker << line[index]
					index += 1
				end
				marker << line[index]
				len = marker[/(?<=\()\d+/].to_i
				repeat = marker[/\d+\)$/].to_i
				index += 1
				to_process = ""
				len.times do 
					to_process << line[index]
					index += 1
				end
				@length += repeat * len
			else
				@length += 1
				index += 1
			end
		end
	end

	def output
		puts "length is #{@length}"
	end
end

Part1.new("input.txt")