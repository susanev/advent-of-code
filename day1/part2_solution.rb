class Part1
	def initialize(file_name)
		@directions = [:north, :east, :south, :west]
		@direction = :north
		@seen = {0 => [0]}
		@current = [0,0]
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
					index+=1
				end
			end
		end
	end

	def updateSeen
		if @seen[@current[0]] == nil
			@seen[@current[0]] = [@current[1]]
		elsif !@seen[@current[0]].include?(@current[1])
			@seen[@current[0]].push(@current[1])
		else
			@crossed = true
		end
	end

	def update(instr)
		steps = instr[/[0-9]+/].to_i
		dir = instr[/[L,R]+/] == "R" ? 1 : -1
		@direction = @directions[(@directions.index(@direction) + dir) % @directions.length]
		index = 1
		while !@crossed && index <= steps
			if @direction == :north
				@current[1]+=1
			elsif @direction == :south
				@current[1]-=1
			elsif @direction == :east
				@current[0]+=1
			else
				@current[0]-=1
			end
			index+=1
			updateSeen
			puts @seen
		end
	end

	def output
		puts "#{@current[0].abs + @current[1].abs} blocks away"
	end
end

Part1.new("input.txt")



