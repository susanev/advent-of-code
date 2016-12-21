# susan evans
# last edited 12/20/2016
# advent of code 2016, day 19, part 1

# josephus_problem function inspired by https://youtu.be/uCsD3ZGzMgE

class Part1
	def initialize(file_name)
		# @elves = Array(1..File.open(file_name, "r").first.to_i)
		# pass_presents
		n = File.open(file_name, "r").first.to_i
		@winning_elf = josephus_problem(n)
		output
	end

	def josephus_problem(n)
		return 2 * (n - 2 ** (n.to_s(2).length - 1)) + 1
	end

	def pass_presents
		until @elves.length == 1
			@elves = @elves.each_index.select { |i| i % 2 == 0 && (@elves.length % 2 == 0 || i != 0) }.map { |i| @elves[i] }
		end
	end

	def output
		puts "#{@winning_elf} gets all the presents"
	end
end

Part1.new("input.txt")