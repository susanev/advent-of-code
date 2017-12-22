# susan evans
# last edited 12/21/2017
# advent of code 2017, day 22, part 1

class Part1
	def initialize(file_name)
		@dirs = [:north, :east, :south, :west]
		@width = 71#25
		@pos = [35, 35]#[12, 12]
		@dir = :north
		@grid = []
		@count = 0
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
		31.times do
			@grid += Array.new(71, ".")
		end
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@grid += Array.new(31, ".") + line.chomp.delete(" ").split("") + Array.new(31, ".")
			end
		end
		31.times do
			@grid += Array.new(71, ".")
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
		if @grid[@pos[0] + @pos[1] * @width] == "."
			@dir = @dirs[(@dirs.index(@dir) - 1) % @dirs.length]
			@grid[@pos[0] + @pos[1] * @width] = "#"
			@count += 1
		else
			@dir = @dirs[(@dirs.index(@dir) + 1) % @dirs.length]
			@grid[@pos[0] + @pos[1] * @width] = "."
		end
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
