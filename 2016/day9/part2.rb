# susan evans
# last edited 12/09/2016
# advent of code 2016, day 9, part 2
# needs to be cleaned

class Part2
	def initialize(file_name)
		@length = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@length += count(line)
			end
		end
	end

	# recursively counts the length
	def count(line)
		index = 0
		new_len = 0
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
				# if no more markers, then add to length
				# otherwise recursively call this method until
				# no more markers
				if !to_process.include? "("
					new_len += repeat * len
				else
					new_len += repeat * count(to_process)
				end
			else
				new_len += 1
				index += 1
			end
		end
		return new_len
	end

	def output
		puts "length is #{@length}"
	end
end

Part2.new("input.txt")