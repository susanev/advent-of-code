# susan evans
# last edited 12/18/2017
# advent of code 2017, day 19, part 1

class Part1
	def initialize(file_name)
		@grid = []
		@path = []
		@x_pos = 0
		@y_pos = 0
		@steps = 0
		processFile(file_name)
		find_start
		find_path
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@grid.push(line.split(""))
			end
		end
	end

	def find_start
		current = nil
		while current != "|"
			@x_pos += 1
			current = @grid[0][@x_pos]
		end
	end

	def find_path
		while !at_end
			@y_pos + 1 >= @grid.length || @grid[@y_pos + 1][@x_pos] == " " ?
				up_down(-1) :
				up_down(1)
			@x_pos + 1 >= @grid[@y_pos].length || @grid[@y_pos][@x_pos + 1] == " " ?
				left_right(-1) :
				left_right(1)
		end
	end

	def at_end
		return @grid[@y_pos][@x_pos] == " " && surrounding_spaces == 3
	end

	def surrounding_spaces
		spaces = 0
		if @y_pos + 1 < @grid.length && @grid[@y_pos + 1][@x_pos] == " "
			spaces += 1
		end
		if @y_pos - 1 > -1 && @grid[@y_pos - 1][@x_pos] == " "
			spaces += 1
		end
		if @x_pos + 1 < @grid[@y_pos].length && @grid[@y_pos][@x_pos + 1] == " "
			spaces += 1
		end
		if @x_pos - 1 > -1 && @grid[@y_pos][@x_pos - 1] == " "
			spaces += 1
		end
		return spaces
	end

	def up_down(dir)
		while @y_pos + dir < @grid.length && 
				@grid[@y_pos + dir][@x_pos] != " "
			if is_letter(@grid[@y_pos + dir][@x_pos])
				@path.push(@grid[@y_pos + dir][@x_pos])
				@grid[@y_pos + dir][@x_pos] = " "
			end
			@y_pos += dir
			@steps += 1
		end
	end

	def left_right(dir)
		while @x_pos + dir < @grid[@y_pos].length && 
				@grid[@y_pos][@x_pos + dir] != " "
			if is_letter(@grid[@y_pos][@x_pos + dir])
				@path.push(@grid[@y_pos][@x_pos + dir])
				@grid[@y_pos][@x_pos + dir] = " "
			end
			@x_pos += dir
			@steps += 1
		end
	end

	def is_letter(item)
		return !"|+- ".include?(item)
	end

	def output
		puts "#{@steps + 1}"
	end
end

Part1.new("input.txt")


