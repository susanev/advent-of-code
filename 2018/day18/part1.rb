# susan evans
# last edited 12/17/2018
# advent of code 2018, day 18, part 1

class Part1
	def initialize(file_name)
		@dirs = [[-1, -1], [0, -1], [1, -1],
		 		 [-1, 0],			[1, 0],
		 		 [-1, 1],  [0, 1],  [1, 1]]
		@width = nil
		@height = nil
		@forest = {}
		process_file(file_name)
		process
		output
	end

	def print_forest
		for y in 0...@height
			for x in 0...@width
				print @forest[[x,y]]
			end
			print "\n"
		end
		print "\n"
	end

	def process_file(file_name)
		input = File.open(file_name, "r").readlines.map{|str| str.chomp.split("")}
		@width = input[0].length
		@height = input.length
		for y in 0...@height
			for x in 0...@width
				@forest[[x,y]] = input[y][x]
			end
		end
	end

	def process
		10.times do
			second
		end
	end

	def second
		new_forest = {}
		for y in 0...@height
			for x in 0...@width
				# puts three_or_more?(x, y, "|")
				if @forest[[x,y]] == "." && three_or_more?(x, y, "|")
					new_forest[[x,y]] = "|"
				elsif @forest[[x,y]] == "."
					new_forest[[x,y]] = "."
				elsif @forest[[x,y]] == "|" && three_or_more?(x, y, "#")
					new_forest[[x,y]] = "#"
				elsif @forest[[x,y]] == "|"
					new_forest[[x,y]] = "|"
				elsif @forest[[x,y]] == "#" && remain_lumberyard?(x, y)
					new_forest[[x,y]] = "#"
				else
					new_forest[[x,y]] = "."
				end
			end
		end
		@forest = new_forest
	end

	def remain_lumberyard?(x, y)
		lumberyards = 0
		trees = 0
		@dirs.each do |dir|
			if valid_move(x + dir[0], y + dir[1])
				if @forest[[x + dir[0],y + dir[1]]] == "|"
					trees += 1
				elsif @forest[[x + dir[0],y + dir[1]]] == "#"
					lumberyards += 1
				end
			end
		end
		return lumberyards > 0 && trees > 0
	end

	def three_or_more?(x, y, thing)
		count = 0
		@dirs.each do |dir|
			if valid_move(x + dir[0], y + dir[1]) &&
					@forest[[(x + dir[0]), (y + dir[1])]] == thing
				count += 1
			end
		end
		return count >= 3
	end

	def valid_move(x, y)
		return x < @width &&
				y < @height &&
				x > -1 &&
				y > -1
	end

	def output
		puts @forest.values.count("|") * @forest.values.count("#")
	end
end

Part1.new("input.txt")


