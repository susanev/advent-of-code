# susan evans
# last edited 12/15/2018
# advent of code 2018, day 15, part 1

# generating a map of the walls (#),
# open cavern (.), and starting position
# of every Goblin (G) and Elf (E) (your puzzle input).

class PriorityQueue
	def initialize
		@list = []
	end

	def push(element)
		@list.push(element)
	end

	def pop
		@list = @list.sort.reverse
		return @list.pop
	end

	def empty?
		return @list.length == 0
	end

	def to_s
		output = ""
		@list.each do |item|
			output << item.to_s + ", "
		end
		return output
	end
end

class Element
	TYPE_TO_STR = {"." => :open, "#" => :wall, "E" => :E, "G" => :G}

	attr_accessor :x, :y, :type, :priority, :attack, :hit, :str

	def initialize(x, y, str)
		@x = x
		@y = y
		@type = TYPE_TO_STR[str]
		@str = str
		@priority = 0
		if type == :E || type == :G
			@attack = 3
			@hit = 200
		end
	end

	def <=>(other)
		return [@y, @x] <=> [other.y , other.x]
	end

	def to_s
		return @str
		#return "x: " + @x.to_s + " y: " + @y.to_s + " " + @str
	end
end

class Part1
	SQUARES = [[0, -1], [-1, 0], [1, 0], [0, 1]]

	def initialize(file_name)
		@width = nil
		@height = nil
		@map = {}
		@elves = []
		@goblins = []
		process_file(file_name)
		# find_monsters
		4.times do
		turn
	end
		#game
		print_map
		#output
	end

	def print_map
		for y in 0...@height
			for x in 0...@width
				print @map[[x, y]]
			end
			print "\n"
		end
		print "\n"
	end

	def process_file(file_name)
		input = File.open(file_name, "r").
				readlines.map(&:chomp)
		@height = input.length
		@width = input[0].length
		for y in 0...@height
			for x in 0...@width			
				@map[[x,y]] = Element.new(x, y, input[y][x])
			end
		end
	end

	def find_monsters
		@elves = []
		@goblins = []
		for y in 0...@height
			for x in 0...@width			
				if @map[[x,y]].type == :E
					@elves.push(@map[[x,y]])
				elsif @map[[x,y]].type == :G
					@goblins.push(@map[[x,y]])
				end
			end
		end
	end

	def turn
		find_monsters
		@monsters = (@elves + @goblins).sort

		@all_moves = []
		@monsters.each do |monster|
			target = find_targets(monster)
			if target != nil
				target.hit -= monster.attack
				if target.hit <= 0
					target.type = :open
					target.str = "."
				end
			elsif find_open_squares(monster).length > 0
				@all_moves.push(move(monster))
			end
		end

		@all_moves.each do |move|
			prev_x = move[:monster].x
			prev_y = move[:monster].y
			new_x = move[:path].x
			new_y = move[:path].y
			type = move[:monster].type
			str = move[:monster].str
			attack = move[:monster].attack
			hit = move[:monster].hit
			@map[[prev_x, prev_y]].type = :open
			@map[[prev_x, prev_y]].str = "."
			@map[[new_x, new_y]].type = type
			@map[[new_x, new_y]].str = str	
			@map[[new_x, new_y]].hit = hit
			@map[[new_x, new_y]].attack = attack		
		end
	end

	def find_targets(monster)
		look_for = nil
		if monster.type == :E
			look_for = :G
		else # :G
			look_for = :E
		end
		targets = []
		SQUARES.each do |square|
			x = monster.x + square[0]
			y = monster.y + square[1]
			if @map[[x, y]].type == look_for
				targets.push(@map[[x, y]])
			end
		end
		if targets.length == 0
			return nil
		else
			return find_smallest_hit_points(targets)
		end
	end

	def find_smallest_hit_points(targets)
		smallest = targets.map{ |target| target.hit }.min
		targets.each do |target|
			if target.hit == smallest
				return target
			end
		end
	end

	def find_open_squares(monster)
		open_squares = []
		SQUARES.each do |square|
			x = monster.x + square[0]
			y = monster.y + square[1]
			if @map[[x, y]].type == :open
				open_squares.push(@map[[x,y]])
			end
		end
		return open_squares
	end

	def move(monster)
		moves = []
		if monster.type == :E
			@goblins.each do |goblin|
				open_squares = find_open_squares(goblin)
				distances = []
				open_squares.each do |square|
					distances.push(get_distance(monster, square))
				end
				shortest = find_shortest_distance(distances)
				moves.push({monster: monster, path: shortest[0], cost: shortest[1]})
			end
		else # elf
			@elves.each do |elf|
				open_squares = find_open_squares(elf)
				distances = []

				open_squares.each do |square|
					distances.push(get_distance(monster, square))
				end
				shortest = find_shortest_distance(distances)
				moves.push({monster: monster, path: shortest[0], cost: shortest[1]})
			end
		end

		chosen_path = moves.map{ |move| move[:cost] }.min
		moves.each do |move|
			if move[:cost] == chosen_path
				return move
			end
		end
	end

	def find_shortest_distance(distances)
		shortest = distances.map{ |distance| distance[1] }.min
		distances.each do |distance|
			if distance[1] == shortest
				return distance
			end
		end
	end		

 	def get_distance(start, goal)
		frontier = PriorityQueue.new
		frontier.push(start)
		came_from = {}
		came_from[start] = nil
		cost_so_far = {}
		cost_so_far[start] = 0

		while !frontier.empty?
			current = frontier.pop

			if current == goal
				break
			end

			neighbors = get_neighbors(current).sort

			neighbors.each do |neighbor|
				new_cost = cost_so_far[current] + 1
				if (cost_so_far[neighbor] == nil || new_cost < cost_so_far[neighbor])
					cost_so_far[neighbor] = new_cost
					neighbor.priority = new_cost
					frontier.push(neighbor)
					came_from[neighbor] = current
				end
			end
		end

		current = goal
		path = []

		while current != start
			path.push(current)
			current = came_from[current]
		end

		choice = path.pop

		return [choice, cost_so_far[goal]]
	end

	# def heuristic(a, b)
	# 	return (a.x - b.x).abs + (a.y - b.y).abs
	# end

	def get_neighbors(current)
		neighbors = []
		SQUARES.each do |square|
			x = current.x + square[0]
			y = current.y + square[1]
			if valid_move(x, y)
				neighbors.push(@map[[x,y]])
			end
		end
		return neighbors.sort
	end

	def valid_move(x, y)
		return x > -1 && x < @width && 
				y > -1 && y < @height &&
				@map[[x,y]].type == :open
	end
end

Part1.new("input.txt")


