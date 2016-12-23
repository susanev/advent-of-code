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
		@current =  [0, CONST_WIDTH - 1]
		@data = []
		@zero = []
		@count = 0
		CONST_HEIGHT.times do
			@data.push(Array.new(CONST_WIDTH, 0))
		end
		process_file(file_name)
		move_zero
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
						@zero = [y,x]
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
				elsif i == @current[0] && j ==@current[1]
					output = "[#{output}]"
				end
				print "#{output} "
			end
			print "\n\n"
		end
		puts "---"
	end

	def move_zero
		until @zero[0] == 1 
			if @data[@zero[0]][@zero[1]][:size] < @data[@zero[0] - 1][@zero[1]][:used]
				while @data[@zero[0]][@zero[1]][:size] < @data[@zero[0] - 1][@zero[1]][:used]
					@data[@zero[0]][@zero[1]][:used] = @data[@zero[0]][@zero[1] - 1][:used]
					@data[@zero[0]][@zero[1] - 1][:used] = 0
					@zero[1] -= 1
					@count += 1
				end
			else
				@data[@zero[0]][@zero[1]][:used] += @data[@zero[0] - 1][@zero[1]][:used]
				@data[@zero[0] - 1][@zero[1]][:used] = 0
				@zero[0] -= 1
				@count += 1
			end
		end
		until @zero[1] == CONST_WIDTH - 2
			if @data[@zero[0]][@zero[1]][:size] < @data[@zero[0]][@zero[1] + 1][:used]
				puts "ERROR2!"
			end
			@data[@zero[0]][@zero[1]][:used] += @data[@zero[0]][@zero[1] + 1][:used]
			@data[@zero[0]][@zero[1] + 1][:used] = 0
			@zero[1] += 1
			@count += 1
		end
		until @zero[0] == 1 && @zero[1] == 0
			temp = @data[@current[0]][@current[1] - 1][:used]
			@data[@current[0]][@current[1] - 1][:used] = @data[@current[0]][@current[1]][:used]
			@data[@current[0]][@current[1]][:used] = temp
			@data[@current[0] + 1][@current[1] - 1][:used] = @data[@current[0] + 1][@current[1] - 2][:used]
			@data[@current[0] + 1][@current[1] - 2][:used] = 0
			@zero[1] -= 1
			@current[1] -= 1
			@count += 5
		end

		@data[@current[0] + 1][@current[1] - 1][:used] = @data[@current[0] + 1][@current[1] - 1][:used]
		@data[@current[0]][@current[1] - 1][:used] = @data[@current[0]][@current[1]][:used]
		@data[@current[0]][@current[1]][:used] = 0
		@current[1] -= 1
		@count += 2
	end

	def output
		puts "count: #{@count}"
	end
end

Part2.new("input.txt")