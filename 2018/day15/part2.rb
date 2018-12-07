# susan evans
# last edited 12/14/2017
# advent of code 2017, day 15, part 2

class Part2
	def initialize(file_name)
		@A = 16807
		@B = 48271
		@mod = 2147483647
		@A_vals = []
		@B_vals = []
		@a_index = 0
		@b_index = 0
		@currA = 679
		@currB = 771
		@total = 0
		@compare = 0
		while @compare <= 5000000
			count
		end	
		output
	end

	def count
		@currA = (@currA * @A) % @mod
		@currB = (@currB * @B) % @mod

		if @currA % 4 == 0
			@A_vals.push(@currA)
		end
		if @currB % 8 == 0
			@B_vals.push(@currB)
		end

		if @a_index < @A_vals.length && @b_index < @B_vals.length
			@compare += 1
			binA = @A_vals[@a_index].to_s(2)
			binB = @B_vals[@b_index].to_s(2)
			if binA[binA.length - 16...binA.length] ==
					binB[binB.length - 16...binB.length]
				@total += 1
			end
			@a_index += 1
			@b_index += 1
		end
	end

	def output
		puts "#{@total}"
	end
end

Part2.new("input.txt")

