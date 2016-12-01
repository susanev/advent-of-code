class Part1
	def initialize(file_name)
		@directions = [:north, :east, :south, :west]
		@counts = {:north => 0, :east => 0, :south => 0, :west => 0}
		@direction = :north
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				data = line.split(", ")
				data.each do |instr|
					update(instr)
				end
			end
		end
	end

	def update(instr)
		steps = instr[/[0-9]+/].to_i
		dir = instr[/[L,R]+/] == "R" ? 1 : -1
		@direction = @directions[(@directions.index(@direction) + dir) % @directions.length]
		@counts[@direction]+=steps
	end

	def output
		puts "#{(@counts[:north]  - @counts[:south]).abs + (@counts[:east] - @counts[:west]).abs} blocks away"
	end
end

Part1.new("input.txt")



