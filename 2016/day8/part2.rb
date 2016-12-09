# susan evans
# last edited 12/08/2016
# advent of code 2016, day 8, part 2
# creates a grid of lights, then processes a file
# that gives instructions about which lights should
# be turned on, then displays the grid of lights

class Part2
	CONST_SCREEN_WIDTH = 50
	CONST_SCREEN_HEIGHT = 6

	def initialize(file_name)
		# creates the @screen of CONST_SCREEN_HEIGHT x
		# CONST_SCREEN_WIDTH, with all values set to false 
		# (lights turned off)
		@screen = []
		CONST_SCREEN_HEIGHT.times do
			@screen.push(Array.new(CONST_SCREEN_WIDTH, false))
		end
		process_file(file_name)
		print_screen
	end

	# reads the file named file_name line by line
	# using regex to pull out important information
	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if line.include? "rect"
					turn_on_rect(line[/(?<=rect )\d+/].to_i, line[/(?<=x)\d+/].to_i)
				end
				pos = line[/(?<=\=)\d+/].to_i
				amt = line[/(?<=by )\d+/].to_i
				if line.include? "row"
					rotate_lights(:row, pos, amt)
				else #col
					rotate_lights(:col, pos, amt)
				end
			end
		end
	end

	# updates @screen with an area of
	# width x height 
	def turn_on_rect(width, height)
		(0...height).each do |row|
			(0...width).each do |col|	
				@screen[row][col] = true
			end
		end
	end

	# rotates row or col of @screen
	# using pos as the row or column
	# and amt as the number of rotations
	def rotate_lights(type, pos, amt)
		if type == :row
			@screen[pos] = @screen[pos].rotate!(-amt)
		else # type == :col
			# this can be done in place
			# will revisit later
			arr = []
			@screen.each do |row|
				arr.push(row[pos])
			end
			arr.rotate!(-amt)
			@screen.each_with_index do |row, index|
				row[pos] = arr[index]
			end
		end
	end

	# prints a gird representing
	# the screen of lights
	def print_screen
		@screen.each do |row|
			row.each do |col|
				print col ? "*" : " "
			end
			print "\n"
		end
	end
end

Part2.new("input.txt")