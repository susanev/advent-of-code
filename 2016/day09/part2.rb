# susan evans
# last edited 12/09/2016
# advent of code 2016, day 9, part 2
# decompresses a file that was compressed
# using markers of the form (numxnum)
# processes all markers, including markers
# inside of marked sections

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
		pos = 0
		sub_len = 0
		while (pos < line.length)
			# if marker, decompress and count length
			# else add 1 to length, for normal character
			if line[pos] == "("
				# substring containing only the marker
				marker = line[pos, line[pos, line.length - pos].index(")") + 1]
				pos += marker.length
				len = marker[/(?<=\()\d+/].to_i
				repeat = marker[/\d+\)$/].to_i
				to_process = line[pos, len]
				pos += len
				# if no more markers, then add to length
				# otherwise recursively call this method until
				# no more markers
				if !to_process.include? "("
					sub_len += repeat * len
				else
					sub_len += repeat * count(to_process)
				end
			else
				sub_len += 1
				pos += 1
			end
		end

		return sub_len
	end

	def output
		puts "length is #{@length}"
	end
end

Part2.new("input.txt")