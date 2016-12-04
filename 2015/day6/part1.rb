class Part1
	CONST_GRID_SIZE = 1000

	def initialize(file_name)
		@light_grid = []
		CONST_GRID_SIZE.times do
			@light_grid.push(Array.new(CONST_GRID_SIZE, false))
		end
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				op = line[/[a-z, ]*(?= \d+)/]
				low = [line[/(?<= )\d+(?=,)/].to_i, line[/(?<=,)\d+(?= )/].to_i]
				high = [line[/(?<=through )\d+/].to_i, line[/\d+$/].to_i]
				updateLights(op, low, high)
			end
		end
	end

	def updateLights(op, low, high)
		(low[0]..high[0]).each do |row_index|
			(low[1]..high[1]).each do |col_index|
				if op == "turn on"
					@light_grid[row_index][col_index] = true
				elsif op == "turn off"
					@light_grid[row_index][col_index] = false
				else
					@light_grid[row_index][col_index] = !@light_grid[row_index][col_index]
				end
			end
		end
	end

	def output
		puts "#{@light_grid.flatten.map {|x| x ? 1 : 0}.reduce(:+)} lights are lit"
	end
end

Part1.new("input.txt")