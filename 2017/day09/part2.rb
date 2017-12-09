# susan evans
# last edited 12/08/2017
# advent of code 2017, day 9, part 2

class Part2
	def initialize(file_name)
		@garbage_count = 0
		@junk = ">!,<"
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				count_junk(line.chomp.split(""))
			end
		end
	end

	def count_junk(line)
		pos = 0
		garbage = false
		while pos < line.length
			c = line[pos]
			if @junk.include?(c) || garbage
				line.delete_at(pos)
				if c == ">"
					garbage = false
				elsif c == "!"
					line.delete_at(pos)
				elsif garbage
					@garbage_count += 1
				elsif c == "<"
					garbage = true
				end
			else
				pos += 1
			end
		end
	end

	def output
		puts "#{@garbage_count}"
	end
end

Part2.new("input.txt")