# susan evans
# last edited 12/14/2018
# advent of code 2018, day 14, part 2

class Part2
	def initialize(file_name)
		@recipes = [3, 7]
		recipe(process_file(file_name))
		output
	end

	def process_file(file_name)
		return File.open(file_name, "r").
				readlines[0].split("").map(&:to_i)
	end

	def recipe(input)
		elf1 = 0
		elf2 = 1
		
		# structured this way, so that it will short circuit
		# and such do less calculations
		until @recipes.length > input.length - 1 &&
				@recipes[@recipes.length - 6] == input[0] &&
				@recipes[@recipes.length - 5] == input[1] &&
				@recipes[@recipes.length - 4] == input[2] &&
				@recipes[@recipes.length - 3] == input[3] &&
				@recipes[@recipes.length - 2] == input[4] &&
				@recipes[@recipes.length - 1] == input[5]

			sum = @recipes[elf1] + @recipes[elf2]

			if sum > 9
				@recipes.push(sum / 10)
			end
			@recipes.push(sum % 10)

			elf1 = (@recipes[elf1] + elf1 + 1) % @recipes.length
			elf2 = (@recipes[elf2] + elf2 + 1) % @recipes.length
		end
	end

	def output
		puts @recipes.join.index("030121")
	end
end

Part2.new("input.txt")
