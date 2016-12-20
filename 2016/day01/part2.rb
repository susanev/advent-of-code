class Part2
	CONST_DIRECTIONS = [:north, :east, :south, :west]
	
	def initialize(file_name)
		@direction = :north
		@seen = {0 => [0]}
		@current = [0, 0]
		@croseed = false
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				data = line.split(", ")
				index = 0
				until @crossed || index >= data.length
					update(data[index])
					index += 1
				end
			end
		end
	end

	def update(instr)
		steps = instr[/[0-9]+/].to_i
		dir = instr[/[L,R]/] == "R" ? 1 : -1
		@direction = CONST_DIRECTIONS[(CONST_DIRECTIONS.index(@direction) + dir) % CONST_DIRECTIONS.length]
		index = 1
		until @crossed || index > steps
			case @direction
			when :north
				@current[1] += 1
			when :south
				@current[1] -= 1
			when :east
				@current[0] += 1
			else #west
				@current[0] -= 1
			end
			index += 1
			updateSeen
		end
	end

	def updateSeen
		if !@seen.include?(@current[0])
			@seen[@current[0]] = [@current[1]]
		elsif !@seen[@current[0]].include?(@current[1])
			@seen[@current[0]].push(@current[1])
		else
			@crossed = true
		end
	end

	def output
		puts "#{@current[0].abs + @current[1].abs} blocks away"
	end
end

Part2.new("input.txt")