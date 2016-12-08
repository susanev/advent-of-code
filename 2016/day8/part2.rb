class Part1
	CONST_GRID_SIZE = 1000

	def initialize(file_name)
		@screen = []
		6.times do
			@screen.push(Array.new(50, false))
		end
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if line.include? "rect"
					x = line[/(?<=rect )\d+/].to_i
					y = line[/(?<=x)\d+/].to_i
					updateLights(["rect", x, y])
				elsif line.include? "row"
					x = line[/(?<=\=)\d+/].to_i
					y = line[/(?<=by )\d+/].to_i
					updateLights(["row", x, y])
				else #col
					x = line[/(?<=\=)\d+/].to_i
					y = line[/(?<=by )\d+/].to_i
					updateLights(["col", x, y])
				end
			end
		end
	end

	def updateLights(op)
		if op[0] == "rect"
			(0...op[2]).each do |row_index|
				(0...op[1]).each do |col_index|	 
					@screen[row_index][col_index] = true
				end
			end
		elsif  op[0] == "row"
			@screen[op[1]] = rotateArray(@screen[op[1]], op[2])
		elsif op[0] == "col"
			arr = []
			@screen.each do |row|
				arr.push(row[op[1]])
			end
			new_arr = rotateArray(arr, op[2])
			@screen.each_with_index do |row, index|
				row[op[1]] = new_arr[index]
			end
		end
	end

	def rotateArray(arr, n)
		new_arr = Array.new(arr.length)
		arr.length.times do |i|
			new_arr[(n + i)%arr.length] = arr[i]
		end
		return new_arr
	end

	def output
		@screen.each do |row|
			row.each do |col|
				print col ? 1 : " "
			end
			print "\n"
		end
		# puts "#{@screen.flatten.map {|x| x ? 1 : 0}.reduce(:+)} lights are lit"
	end
end

Part1.new("input.txt")