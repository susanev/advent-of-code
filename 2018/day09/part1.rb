# susan evans
# last edited 12/08/2017
# advent of code 2017, day 9, part 1

class Part1
	def initialize(file_name)
		@lines = []
		@sum = 0
		@garbage = 0
		@junk = ">!,<"
		processFile(file_name)
		count
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lines.push(remove_junk(line.chomp.split("")))
			end
		end
	end

	def remove_junk(line)
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
				elsif c == "<"
					garbage = true
				end
			else
				pos += 1
			end
		end
		return line
	end

	def count
		@lines.each do |line|
			open_brackets = 0
			inc = 1
			sum = 0
			line.each do |c|
				if c == "{"
					open_brackets += 1
					sum += inc
					inc += 1
				elsif c == "}"
					inc -= 1
				end
			end
			@sum += sum
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
