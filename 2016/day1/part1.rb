class Part1
	def initialize(file_name)
		@directions = [:north, :east, :south, :west]
		@pairs = {north: :north_south, south: :north_south, east: :east_west, west: :east_west}
		@totals = {north_south: 0, east_west: 0}
		@direction = :north
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.split(", ").each do |instr|
					update(instr)
				end
			end
		end
	end

	def update(instr)
		steps = instr[/[0-9]+/].to_i
		dir = instr[/[L,R]/] == "R" ? 1 : -1
		@direction = @directions[(@directions.index(@direction) + dir) % @directions.length]
		if @direction == :south || @direction == :west
			steps *= -1
		end
		@totals[@pairs[@direction]] += steps
	end

	def output
		puts "#{@totals[:north_south].abs + @totals[:east_west].abs} blocks away"
	end
end

Part1.new("input.txt")