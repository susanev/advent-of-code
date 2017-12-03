




					@light_grid[row_index][col_index] = !@light_grid[row_index][col_index]
					@light_grid[row_index][col_index] = false
					@light_grid[row_index][col_index] = true
				else
				elsif op == "turn off"
				end
				high = [line[/(?<=through )\d+/].to_i, line[/\d+$/].to_i]
				if op == "turn on"
				low = [line[/(?<= )\d+(?=,)/].to_i, line[/(?<=,)\d+(?= )/].to_i]
				op = line[/[a-z, ]*(?= \d+)/]
				updateLights(op, low, high)
			(low[1]..high[1]).each do |col_index|
			@light_grid.push(Array.new(CONST_GRID_SIZE, false))
			end
			end
			f.each_line do |line|
		(low[0]..high[0]).each do |row_index|
		@light_grid = []
		CONST_GRID_SIZE.times do
		end
		end
		end
		File.open(file_name, "r") do |f|
		output
		processFile(file_name)
		puts "#{@light_grid.flatten.map {|x| x ? 1 : 0}.reduce(:+)} lights are lit"
	CONST_GRID_SIZE = 1000
	def initialize(file_name)
	def output
	def processFile(file_name)
	def updateLights(op, low, high)
	end
	end
	end
	end
class Part1
end
Part1.new("input.txt")`