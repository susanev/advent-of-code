directions = [:north, :east, :south, :west]
counts = {:north => 0, :east => 0, :south => 0, :west => 0}

File.open("input.txt", "r") do |f|
	f.each_line do |line|
		data = line.split(", ")
		direction = :north
		blocks = 0
		data.each do |instr|
			steps = instr[/[0-9]+/].to_i
			dir = instr[/[L,R]+/] == "R" ? 1 : -1
			direction = directions[(directions.index(direction) + dir) % directions.length]
			counts[direction]+=steps
		end
	end
end

puts "#{(counts[:north]  - counts[:south]).abs + (counts[:east] - counts[:west]).abs} blocks away"