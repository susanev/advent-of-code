class Part2
	CONST_SCREEN_WIDTH = 50
	CONST_SCREEN_HEIGHT = 6

	def initialize(file_name)
		@screen = []
		CONST_SCREEN_HEIGHT.times do
			@screen.push(Array.new(CONST_SCREEN_WIDTH, false))
		end
		process_file(file_name)
		print_screen
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if line.include? "rect"
					update_lights(:rect, line[/(?<=rect )\d+/].to_i, line[/(?<=x)\d+/].to_i)
				end
				pos = line[/(?<=\=)\d+/].to_i
				amt = line[/(?<=by )\d+/].to_i
				if line.include? "row"
					update_lights(:row, pos, amt)
				else #col
					update_lights(:col, pos, amt)
				end
			end
		end
	end

	def update_lights(type, pos, amt)
		if type == :rect
			(0...amt).each do |row|
				(0...pos).each do |col|	 
					@screen[row][col] = true
				end
			end
		elsif type == :row
			@screen[pos] = rotateArray(@screen[pos], amt)
		elsif type == :col
			arr = []
			@screen.each do |row|
				arr.push(row[pos])
			end
			new_arr = rotateArray(arr, amt)
			@screen.each_with_index do |row, index|
				row[pos] = new_arr[index]
			end
		end
	end

	def rotate_array(arr, n)
		new_arr = Array.new(arr.length)
		arr.length.times do |i|
			new_arr[(n + i) % arr.length] = arr[i]
		end
		return new_arr
	end

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