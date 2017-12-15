# susan evans
# last edited 12/14/2017
# advent of code 2017, day 15, part 1

class Part1
	def initialize(file_name)
		@A = 16807
		@B = 48271
		@mod = 2147483647
		@currA = 679
		@currB = 771
		@total = 0
		40000000.times do |n|
			puts n
			count
		end
			
		output
	end

	def count
		@currA = (@currA * @A) % @mod
		@currB = (@currB * @B) % @mod
		binA = @currA.to_s(2)
		binB = @currB.to_s(2)

		if binA[binA.length - 16...binA.length] ==
				binB[binB.length - 16...binB.length]
			@total += 1
		end
	end

	def output
		puts "#{@total}"
	end
end

Part1.new("input.txt")

