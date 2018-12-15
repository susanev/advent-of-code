# susan evans
# last edited 12/14/2018
# advent of code 2018, day 14, part 2

class Part2
	def initialize(file_name)
		@recipes = [3, 7]
		@elf1 = 0
		@elf2 = 1
		recipe
		output
	end

	def recipe
		# structured this way, so that it will short circuit
		# and such do less calculations
		until @recipes.length > 5 &&
				@recipes[@recipes.length - 6] == 0 &&
				@recipes[@recipes.length - 5] == 3 &&
				@recipes[@recipes.length - 4] == 0 &&
				@recipes[@recipes.length - 3] == 1 &&
				@recipes[@recipes.length - 2] == 2 &&
				@recipes[@recipes.length - 1] == 1

			sum = @recipes[@elf1] + @recipes[@elf2]

			if sum > 9
				@recipes.push(sum / 10)
			end
			@recipes.push(sum % 10)

			@elf1 = (@recipes[@elf1] + @elf1 + 1) % @recipes.length
			@elf2 = (@recipes[@elf2] + @elf2 + 1) % @recipes.length
		end
	end

	def output
		puts @recipes.join.index("030121")
	end
end

Part2.new("input.txt")
