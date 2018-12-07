# susan evans
# last edited 12/16/2017
# advent of code 2017, day 16, part 2

class Part2
	def initialize(file_name)
		@dance = nil
		@programs = "abcdefghijklmnop".split("")
		processFile(file_name)
		many_dances
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@dance = line.split(",")
			end
		end
	end

	def many_dances
		repeat = 0
		dance
		dance_match = @programs.join
		all_programs = [@programs.join]
		while @programs.join != dance_match || repeat == 0
			dance
			repeat += 1
			all_programs.push(@programs.join)
		end
		@programs = all_programs[1000000000 - (1000000000 / repeat * repeat) - 1]
	end

	def dance
		@dance.each do |move|
			if move[0] == "x"
				slash = move.index("/")
				exchange(move[1...slash].to_i, move[slash + 1...move.length].to_i)
			elsif move[0] == "p"
				slash = move.index("/")
				partner(move[1...slash], move[slash + 1...move.length])
			elsif move[0] == "s"
				amt = move[/\d+/].to_i
				if amt < @programs.length
					spin(amt)
				end
			end
		end
	end

	def spin(amt)
		sub_programs = @programs.drop(@programs.length - amt)
		amt.times do
			@programs.delete_at(@programs.length - 1)
		end
		@programs = sub_programs.push(*@programs)
	end

	def exchange(pos1, pos2)
		temp = @programs[pos1]
		@programs[pos1] = @programs[pos2]
		@programs[pos2] = temp
	end

	def partner(prog1, prog2)
		temp = @programs.find_index(prog1)
		@programs[@programs.find_index(prog2)] = prog1
		@programs[temp] = prog2
	end

	def output
		puts "#{@programs}"
	end
end

Part2.new("input.txt")

