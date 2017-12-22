# susan evans
# last edited 12/22/2017
# advent of code 2017, day 22, part 2

class Part2
	def initialize(file_name)
		@dirs = [:north, :east, :south, :west]
		@pos = [12, 12]
		@dir = :north
		@count = 0
		@grid = {}
		processFile(file_name)
		10000000.times do 
			move
		end
	end

	def processFile(file_name)
		xpos = 0
		ypos = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.delete(" ").split("")
				line.each do |item|
					if item == "#"
						@grid[[xpos, ypos]] = :I
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
		curr = @grid[@pos]
		if curr.nil?
			@dir = @dirs[(@dirs.index(@dir) - 1) % @dirs.length]
			@grid[@pos]= :W
		elsif curr == :W
			@grid[@pos] = :I
			@count += 1
		elsif curr == :I
			@dir = @dirs[(@dirs.index(@dir) + 1) % @dirs.length]
			@grid[@pos] = :F
		else # :F
			@dir = @dirs[(@dirs.index(@dir) + 2) % @dirs.length]
			@grid.delete(@pos)
		end
	end

	def output
		puts "#{@count}"
	end
end

Part2.new("input.txt")
