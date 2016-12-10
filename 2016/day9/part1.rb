# susan evans
# last edited 12/08/2016
# advent of code 2016, day 9, part 1
# decompresses a file that was compressed
# using markers of the form (numxnum)
# does not process markers within markers

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

	# counts the decompressed length
	def count(line)
		pos = 0
		while (pos < line.length)
			# if marker, decompress and count length
			# else add 1 to length, for normal character
			if line[pos] == "("
				# substring containing only the marker
				marker = line[pos, line[pos, line.length - pos].index(")") + 1]
				len = marker[/(?<=\()\d+/].to_i
				repeat = marker[/\d+\)$/].to_i
				@length += repeat * len

				# move pos onto next piece of data
				pos += marker.length + len
			else
				@length += 1
				pos += 1
			end
		end
	end

	def output
		puts "length is #{@length}"
	end
end

Part1.new("input.txt")