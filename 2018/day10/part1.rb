# susan evans
# last edited 12/10/2018
# advent of code 2018, day 10, part 1

class Part1
	def initialize(file_name)
		@points = []
		@output_file = File.open("output.txt", 'w')
		process_file(file_name)
		process
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				pos_x, pos_y, v_x, v_y = line.scan(/-*\d+/).map(&:to_i)
				@points.push({pos_x: pos_x, pos_y: pos_y,
						v_x: v_x, v_y: v_y});
			end
		end
	end

	def process
		while (!all_touching)
			@points.each do |point|
				point[:pos_x] += point[:v_x]
				point[:pos_y] += point[:v_y]
			end
		end
		print_grid
	end

	def all_touching
		true_count = 0
		for i in 0...@points.length
			found = false
			for j in 0...@points.length
				if i != j
					if ((@points[i][:pos_x] - @points[j][:pos_x]).abs <= 4 &&
							@points[i][:pos_y] == @points[j][:pos_y]) ||
							((@points[i][:pos_y] - @points[j][:pos_y]).abs <= 4 &&
							@points[i][:pos_x] == @points[j][:pos_x])
						found = true
					end
				end
			end
			if !found
				return false
			end
		end
		return true
	end

	def print_grid
		grid = {}
		min_x = @points[0][:pos_x]
		min_y = @points[0][:pos_y]
		max_x = @points[0][:pos_x]
		max_y = @points[0][:pos_y]
		@points.each do |point|
			min_x = [min_x, point[:pos_x]].min
			min_y = [min_y, point[:pos_y]].min
			max_x = [max_x, point[:pos_x]].max 
			max_y = [max_y, point[:pos_y]].max 
			grid[[point[:pos_x], point[:pos_y]]] = true
		end
		
		for y in min_y..max_y
			for x in min_x..max_x
				if grid[[x, y]]
					@output_file.write("# ")
				else
					@output_file.write(". ")
				end
			end
			@output_file.write("\n")
		end
		@output_file.write("\n")
	end
end

Part1.new("input.txt")
