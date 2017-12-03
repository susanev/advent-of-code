# susan evans
# last edited 12/10/2016
# advent of code 2015, day 8, part 1
# counts the total number of characters in the file
# and the number of characters stored in strings
# in memory and prints the difference

class Part1
	def initialize(file_name)
		@total = 0
		@in_memory = 0
		# maps the escape sequences to the amount in memory
		# and the number of characters they take up (to be
		# used with shifting pos when iterating through
		# the string)
		@seqs = { "\"\"" => {mem: 0, pos: 2}, 
							"\\x" => {mem: 1, pos: 4},
							"\\\\" => {mem: 1, pos: 2},
							"\\\"" => {mem: 1, pos: 2} }
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				@total += line.length
				# parameter is line with surrounding quotes removed
				count_in_memory(line[1,line.length - 2])
			end
		end
	end

	def count_in_memory(str)
		pos = 0
		while pos < str.length
			# if normal character, increment and move forwrad
			# otherwise pull from @seqs
			if @seqs[str[pos, 2]].nil?
				@in_memory += 1
				pos += 1
			else
				@in_memory += @seqs[str[pos, 2]][:mem]
				pos += @seqs[str[pos, 2]][:pos]
			end
		end
	end

	def output
		puts "difference: #{@total - @in_memory}"
	end
end

Part1.new("input.txt")