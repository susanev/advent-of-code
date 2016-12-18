# susan evans
# last edited 12/17/2016
# advent of code 2016, day 18, part 2

class Part2
	CONST_ROWS = 400000
	CONST_COLS = 100
	CONST_TRAPS = ["^^.", ".^^", "^..", "..^"]

	def initialize(file_name)
		@safe_tiles = count_safe_tiles(file_name)
		output
	end

	def count_safe_tiles(file_name)
		prev_row = ".#{File.open(file_name, "r").first}."
		count = prev_row.count(".") - 2
		(CONST_ROWS - 1).times do
			new_row = ""
			(1..CONST_COLS).each do |col|
				if is_trap(prev_row, col)
					new_row << "^"	
				else
					new_row << "."
				end
			end
			count += new_row.count(".")
			prev_row = ".#{new_row}."
		end
		return count
	end

	# pre-condition, col > 0 && col < row.length - 1
	def is_trap(row, col)
		CONST_TRAPS.each do |t|
			if row[col - 1, 3] == t
				return true
			end
		end
		return false
	end

	def output
		puts "There are #{@safe_tiles} safe tiles"
	end
end

Part2.new("input.txt")