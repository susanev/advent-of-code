# susan evans
# last edited 12/14/2018
# advent of code 2018, day 14, part 1

# 030121

class Part1
	def initialize(file_name)
		@recipes = [3, 7]
		@elf1 = 0
		@elf2 = 1
		recipe
		output
	end

	def recipe
		until @recipes.length == (30121 + 10)
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
		puts @recipes.join[@recipes.length-10..@recipes.length-1]
	end
end

Part1.new("input.txt")
