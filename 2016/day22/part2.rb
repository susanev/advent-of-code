# susan evans
# last edited 12/23/2016
# advent of code 2016, day 22, part 2

# works
# a big mess that exploits the file data

class Part2
	CONST_WIDTH = 39
	CONST_HEIGHT = 25
  CONST_GOAL = [0, 0]
	def initialize(file_name)
		@data = []
		@current_pos =  [0, CONST_WIDTH - 1]
		@zero_pos = []
		@steps = 0
		CONST_HEIGHT.times do
			@data.push(Array.new(CONST_WIDTH, 0))
		end
		process_file(file_name)
		move_zero
		move_data
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if line.include? "/dev/grid/node"
					loc = line.split("-")
					y = loc[2][/\d+/].to_i
					x = loc[1][/\d+/].to_i
					line = line.split(" ")
					@data[y][x] = {size: line[1].to_i, used: line[2].to_i}
					if @data[y][x][:used] == 0
						@zero_pos = [y,x]
					end
				end
			end
		end
	end

	def display_data
		@data.each_with_index do |row, i|
			row.each_with_index do |data, j|
				output = "#{data[:used]}/#{data[:size]}"
				if i == CONST_GOAL[0] && j == CONST_GOAL[1]
					output = "(#{output})"
				elsif i == @current_pos_pos[0] && j ==@current_pos_pos[1]
					output = "[#{output}]"
				end
				print "#{output} "
			end
			print "\n\n"
		end
	end

	def move_zero
		# moves up to y == 1
		# if not enough space, goes left until can go up
		until @zero_pos[0] == 1 
			zero = @data[@zero_pos[0]][@zero_pos[1]]
			up = @data[@zero_pos[0] - 1][@zero_pos[1]]
			if zero[:size] < up[:used]
				while zero[:size] < up[:used]
					zero[:used] = @data[@zero_pos[0]][@zero_pos[1] - 1][:used]
					@data[@zero_pos[0]][@zero_pos[1] - 1][:used] = 0
					@zero_pos[1] -= 1
					@steps += 1
					zero = @data[@zero_pos[0]][@zero_pos[1]]
					up = @data[@zero_pos[0] - 1][@zero_pos[1]]
				end
			else
				zero[:used] += up[:used]
				up[:used] = 0
				@zero_pos[0] -= 1
				@steps += 1
			end
		end
		# assumes always enough space
		until @zero_pos[1] == CONST_WIDTH - 2
			zero = @data[@zero_pos[0]][@zero_pos[1]]
			right = @data[@zero_pos[0]][@zero_pos[1] + 1]
			zero[:used] += right[:used]
			right[:used] = 0
			@zero_pos[1] += 1
			@steps += 1
		end
	end

	# assumes always enough space
	def move_data
		# moves almost all the way over
		until @zero_pos[0] == 1 && @zero_pos[1] == 0
			curr = @data[@current_pos[0]][@current_pos[1]]
			left = @data[@current_pos[0]][@current_pos[1] - 1]
			diag = @data[@current_pos[0] + 1][@current_pos[1] - 1]
			new_curr = @data[@current_pos[0] + 1][@current_pos[1] - 2]
			temp = left[:used]
			left[:used] = curr[:used]
			curr[:used] = temp
			diag[:used] = new_curr[:used]
			new_curr[:used] = 0
			@zero_pos[1] -= 1
			@current_pos[1] -= 1
			@steps += 5
		end
		# the last two final movements
		curr = @data[@current_pos[0]][@current_pos[1]]
		diag = @data[@current_pos[0] + 1][@current_pos[1] - 1]
		diag[:used] = diag[:used]
		@data[@current_pos[0]][@current_pos[1] - 1][:used] = curr[:used]
		curr[:used] = 0
		@current_pos[1] -= 1
		@steps += 2
	end

	def output
		puts "count: #{@steps}"
	end
end

Part2.new("input.txt")