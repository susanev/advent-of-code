# susan evans
# last edited 12/22/2017
# advent of code 2017, day 22, part 1

class Part1
	def initialize(file_name)
		@dirs = [:north, :east, :south, :west]
		@pos = [12, 12]
		@dir = :north
		@count = 0
		@grid = []
		processFile(file_name)
		10000.times do
			move
		end
		puts @count
	end

	def print_grid
		@grid.each_with_index do |item, item_index|
			if item_index % @width == 0
				puts "\n"
			end
			print item
		end
		puts "\n"
	end

	def processFile(file_name)
		xpos = 0
		ypos = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.delete(" ").split("")
				line.each do |item|
					if item == "#"
						@grid.push({x: xpos, y: ypos})
					end
					xpos += 1
				end
				ypos += 1
				xpos = 0
			end
		end
	end

	def move
		infect
		if @dir == :north
			@pos = [@pos[0], @pos[1] - 1]
		elsif @dir == :east
			@pos = [@pos[0] + 1, @pos[1]]
		elsif @dir == :south
			@pos = [@pos[0], @pos[1] + 1]
		else
			@pos = [@pos[0] - 1, @pos[1]]
		end
	end

	def infect
		curr = @grid.index({x: @pos[0], y: @pos[1]})
		if curr.nil?
			@dir = @dirs[(@dirs.index(@dir) - 1) % @dirs.length]
			@grid.push({x: @pos[0], y: @pos[1]})
			@count += 1
		else
			@dir = @dirs[(@dirs.index(@dir) + 1) % @dirs.length]
			@grid.delete_at(curr)
		end
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
