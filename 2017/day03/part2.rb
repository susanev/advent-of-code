# super sloppy, needs to be refactored

class Part2
	def initialize(file_name)
		@current = :right
		@grid = nil
		@r = 1
		@l = 2
		@u = 1
		@d = 2
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				process(line.to_i)
			end
		end
	end

	def process(num)
		r = 0
		l = 0
		u = 0
		d = 0
		@width = Math.sqrt(num).ceil
		@grid = Array.new(@width) {Array.new(@width, 0)}
		x_pos = @width / 2 
		y_pos = @width / 2
		@grid[y_pos][x_pos] = 1
		while @sum < num
			@grid[y_pos][x_pos] = sum(x_pos, y_pos)
			if @current == :right
				x_pos += 1
				r += 1
				if r == @r
					r = 0
					@r += 2
					@current = :up
				end
			elsif @current == :up
				y_pos -= 1
				u += 1
				if u == @u
					u = 0
					@u += 2
					@current = :left
				end
			elsif @current == :left
				x_pos -= 1
				l += 1
				if l == @l
					l = 0
					@l += 2
					@current = :down
				end
			else 
				y_pos += 1
				d += 1
				if d == @d
					d = 0
					@d += 2
					@current = :right
				end
			end			
		end
	end

	def sum(x_pos, y_pos)
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
		@sum = sum
		return sum
	end

	def output
		puts "#{@sum}"
	end
end

Part2.new("input.txt")