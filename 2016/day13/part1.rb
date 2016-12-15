# susan evans
# last edited 12/12/2016
# advent of code 2016, day 123, part 1

class Part1
	CONST_HEIGHT = 45
	CONST_WIDTH = 45
	CONST_FAV_NUM = 1364

	def initialize(file_name)
		@grid = Array.new(CONST_HEIGHT)
		@grid.length.times do |i|
			@grid[i] = Array.new(CONST_WIDTH)
		end
		build_grid
		display_grid
		puts find_path(1, 1, 0)
		display_grid
		#process_file(file_name)	
		#output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def build_grid
		CONST_HEIGHT.times do |y|
			CONST_WIDTH.times do |x|
				bin = (x * x + 3 * x + 2 * x * y + y + y * y + CONST_FAV_NUM).to_s(2)
				if x == 31 && y == 39
					@grid[y][x] = "?"
 				elsif bin.scan(/1/).count % 2 == 0
					@grid[y][x] = "."
				else
					@grid[y][x] = "#";
				end
			end
		end
	end

	def display_grid
		CONST_HEIGHT.times do |y|
			CONST_WIDTH.times do |x|
				print "#{@grid[y][x]} "
			end
			print "\n"
		end
	end

	def output
		puts ""
	end

	def find_path (x, y, d)
		if x < 0 || x > CONST_WIDTH - 1 || y < 0 || y > CONST_HEIGHT - 1
			return 0
		elsif @grid[y][x] == "?"
			return d
		elsif @grid[y][x] != "."
			return 0;
		end

		@grid[y][x] = "O"
		shortest = 0
		if !(shortest = [find_path(x + 1, y, d + 1),
										find_path(x - 1, y, d + 1),
										find_path(x, y + 1, d + 1),
										find_path(x, y - 1, d + 1)].select{ |n| n > 0 }.min).nil?
			return shortest
		else
			@grid[y][x] = "."
			return 0
		end
	end

	# def find_path (x, y, d)
	#   if x < 0 || x > CONST_WIDTH - 1 ||
	# 			y < 0 || y > CONST_HEIGHT - 1 ||
	# 			@grid[y][x] == "#" || @grid[y][x] == "O"
	# 		return -1
 #  	elsif @grid[y][x] == "?"
 #  		return d
 #  	else
 #  		@grid[y][x] = "O"

	# 		return [find_path(x + 1, y, d + 1),
	# 				    find_path(x - 1, y, d + 1),
	# 				    find_path(x, y + 1, d + 1),
	# 				    find_path(x, y - 1, d + 1)].max
 #  	end
	# end
end

Part1.new("input2.txt")