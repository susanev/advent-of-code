# susan evans
# last edited 12/16/2017
# advent of code 2017, day 17, part 1

class Part1
	def initialize(file_name)
		@buffer = [0]
		@steps = 304
		@pos = 0
		@count = 1
		insert
		output
	end

	def insert
		2017.times do
			@steps.times do
				@pos = (@pos + 1) % @buffer.length
			end
			@pos += 1
			@buffer.insert(@pos, @count)
			@count += 1
		end
	end

	def output
		puts "#{@buffer[@pos + 1]}"
	end
end

Part1.new("input.txt")

