# susan evans
# last edited 12/16/2017
# advent of code 2017, day 17, part 2

class Part2
	def initialize(file_name)
		@steps = 304
		@pos = 0
		@count = 1
		@after_zero = nil
		find
		output
	end

	def find
		50000000.times do
			@pos = (@pos + @steps) % @count
			@pos += 1
			if @pos == 1
				@after_zero = @count
			end
			@count += 1
		end
	end

	def output
		puts "#{@after_zero}"
	end
end

Part2.new("input.txt")

