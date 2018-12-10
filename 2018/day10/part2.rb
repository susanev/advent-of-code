# susan evans
# last edited 12/10/2018
# advent of code 2018, day 10, part 2

class Part2
	def initialize(file_name)
		@points = []
		@seconds = 0
		process_file(file_name)
		process
		output
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
			@seconds += 1
		end
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

	def output
		puts "#{@seconds}"
	end
end

Part2.new("input.txt")
