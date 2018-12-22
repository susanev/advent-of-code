# susan evans
# last edited 12/15/2018
# advent of code 2018, day 15, part 1

# generating a map of the walls (#),
# open cavern (.), and starting position
# of every Goblin (G) and Elf (E) (your puzzle input).
class PriorityQueue
	def initialize
		@elements = []
		@size = 0
	end

	def push(element)
		@elements.push(element)
		@size += 1
	end

	def pop
		@elements.sort!
		item = @elements.delete_at(@size - 1)
		@size -= 1
		return item
	end

	def empty?
		return @elements.empty?
	end
end

class Element
	attr_accessor :monster, :priority

	def initialize(monster, priority)
		@monster = monster
		@priority = priority
	end

	def <=>(other)
		@priority <=> other.priority
	end

	def to_s
		return monster.to_s
	end
end

class Monster
	attr_accessor :x, :y, :type, :attack, :hit

	def initialize(x, y, type)
		@x = x
		@y = y
		@type = type
		@attack = 3
		@hit = 200
	end

	def to_s
		return "x: #{@x} y: #{@y} type: #{@type.to_s}"
	end

	def <=>(other)
		return [@y, @x] <=> [other.y , other.x]
	end
end

class Wall
	attr_accessor :x, :y, :type

	def initialize(x, y, type)
		@x = x
		@y = y
		@type = type
	end
	def to_s
		return "x: #{@x} y: #{@y} type: #{@type.to_s}"
	end
end

class Open
	attr_accessor :x, :y, :type

	def initialize(x, y, type)
		@x = x
		@y = y
		@type = type
	end
	def to_s
		return "x: #{@x} y: #{@y} type: #{@type.to_s}"
	end
end

class Part1
	def initialize(file_name)
		@width = nil
		@height = nil
		@map = {}
		@elves = []
		@goblins = []
		process_file(file_name)
		next_move
		#print_map
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
				type = input[y][x]
				if type == "E" || type == "G"
					monster = Monster.new(x, y, type.to_sym)
					@map[[x,y]] = monster
					if type == "E"
						@elves.push(monster)
					else # G
						@goblins.push(monster)
					end
				elsif type == "."
					@map[[x,y]] = Open.new(x, y, type)
				else #wall
					@map[[x,y]] = Wall.new(x, y, type)
				end
			end
		end
	end

	def next_move
		monsters = (@elves + @goblins).sort

		find_shortest_path(monsters[0], @elves[0])
		# monsters.each do |monster|
		# 	if monster.type == :E
		# 		@goblins.each do |goblin|
		# 			find_shortest_path(monster, goblin)
		# 		end
		# 	else
		# 		@elves.each do |elf|
		# 			find_shortest_path(monster, elf)
		# 		end
		# 	end
		# end
	end

	def find_shortest_path(start, goal)
		frontier = PriorityQueue.new
		ele = Element.new(start, 0)
		frontier.push(ele)
		came_from = {}
		cost_so_far = {}
		came_from[ele] = nil
		cost_so_far[ele] = 0

		while !frontier.empty?
   			current = frontier.pop()
   			if off_by_one(current, goal)
      			break
      		end
   
   			get_neighbors(current).each do |neighbor|
   				puts cost_so_far[current]
      			new_cost = cost_so_far[current] + current.priority + 1
			    if !cost_so_far[neighbor] || new_cost < cost_so_far[neighbor]
			    	cost_so_far[neighbor] = new_cost
			        priority = new_cost + heuristic(goal, neighbor)
			        frontier.push(Element.new(neighbor, priority))
			        came_from[neighbor] = current
			    end
			end
		end
	end

	def heuristic(a, b)
		return (a.x - b.x).abs + (a.y - b.y).abs
	end

	def off_by_one(current, goal)
		return (current.monster.x - 1 == goal.x &&
					current.monster.y == goal.y) ||
				(current.monster.x + 1 == goal.x &&
					current.monster.y == goal.y) ||
				(current.monster.x  == goal.x &&
					current.monster.y + 1 == goal.y) ||
				(current.monster.x == goal.x &&
					current.monster.y - 1 == goal.y) 
 	end

	def get_neighbors(current)
		neighbors = []
		x = current.monster.x
		y = current.monster.y
		if valid_move(x + 1, y)
			neighbors.push(@map[[x+1, y]])
		end
		if valid_move(x - 1, y)
			neighbors.push(@map[[x-1, y]])
		end
		if valid_move(x, y + 1)
			neighbors.push(@map[[x, y+1]])
		end
		if valid_move(x + 1, y - 1)
			neighbors.push(@map[[x, y-1]])
		end
		return neighbors
	end

	def valid_move(x, y)
		return x > -1 && x < @width && 
				y > -1 && y < @height &&
				@map[[x,y]].type == "."
	end


	def output
		puts "#{}"
	end
end

Part1.new("input.txt")

