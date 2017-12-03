class Part2
	def initialize(file_name)
		@order = [:right, :up, :left, :down]
		@current = :right
		@dirs = { right: {max: 1, current: 0}, left: {max: 2, current: 0}, up: {max: 1, current: 0}, down: {max: 2, current: 0}}
		@width = nil
		@grid = nil
		processFile(file_name)
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				num = line.to_i
				@width = Math.sqrt(num).ceil
				@grid = Array.new(@width) {Array.new(@width, 0)}
				process(num)
			end
		end
	end

	def process(num)
		x_pos = @width / 2 
		y_pos = @width / 2
		@grid[y_pos][x_pos] = 1
		sum = 0
		while sum < num
			sum = calc_sum(x_pos, y_pos)
			@grid[y_pos][x_pos] = sum
			if @current == :right
				x_pos += 1
				update_dirs(:right)
			elsif @current == :up
				y_pos -= 1
				update_dirs(:up)
			elsif @current == :left
				x_pos -= 1
				update_dirs(:left)
			else 
				y_pos += 1
				update_dirs(:down)
			end			
		end
		puts "#{sum}"
	end

	def calc_sum(x_pos, y_pos)
		sum = @grid[y_pos][x_pos]
		if x_pos + 1 < @width
			sum += @grid[y_pos][x_pos + 1]
		end
		if x_pos - 1 > -1 
			sum += @grid[y_pos][x_pos - 1]
		end
		if y_pos + 1 < @width
			sum += @grid[y_pos + 1][x_pos]
		end
		if y_pos - 1 > -1
			sum += @grid[y_pos - 1][x_pos]
		end
		if y_pos + 1 < @width && x_pos + 1 < @width 
			sum += @grid[y_pos + 1][x_pos + 1]
		end
		if y_pos - 1 > -1 && x_pos - 1 > -1 
			sum += @grid[y_pos - 1][x_pos - 1]
		end
		if y_pos - 1 > -1 && x_pos + 1 < @width
			sum += @grid[y_pos - 1][x_pos + 1]
		end
		if y_pos + 1 < @width && x_pos - 1 > -1 
			sum += @grid[y_pos + 1][x_pos - 1]
		end
		return sum
	end

	def update_dirs(dir)
		@dirs[dir][:current] += 1
		if @dirs[dir][:current] == @dirs[dir][:max]
			@dirs[dir][:current] = 0
			@dirs[dir][:max] += 2
			@current = @order[(@order.index(dir) + 1) % @order.length]
		end
	end
end

Part2.new("input.txt")