# susan evans
# last edited 12/20/2016
# advent of code 2016, day 19, part 2

class Part2
	def initialize(file_name)
		# answer = 1410630
		find_winner(File.open(file_name, "r").first.to_i)
		output
	end

	def find_winner(goal)
		n = 3 ** (Math.log(goal)/Math.log(3)).floor
		@winning_elf = goal - n
		@winning_elf *= 2 if goal >= n * 2 
	end

	def output
		puts "#{@winning_elf} gets all the presents"
	end
end

Part2.new("input.txt")