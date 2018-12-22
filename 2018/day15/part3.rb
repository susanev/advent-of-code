# fifo
class Queue
	attr_accessor :start_node, :last_node, :size

	def initialize(start_node)
		@start_node = start_node
		@last_node = start_node
		@size = 1
	end

	def add(node)
		@last_node.next_node = node
		@last_node = node
		@size += 1
	end

	def remove
		node = @start_node
		if @size > 1
			@start_node = @start_node.next_node
		end
		@size -= 1
		return node
	end

	def empty?
		return @size <= 0
	end

	def to_s
		output = "Queue: \n"
		node = @start_node
		while node.next_node
			output << node.to_s
			node = node.next_node
		end
		output << node.to_s
	end
end

class Node
	attr_accessor :x, :y, :value, :next_node

	def initialize(x, y, value)
		@x = x
		@y = y
		@value = value
		@next_node = nil
	end

	# def to_s
	# 	return value
	# end
	def to_s
		return "x: #{x} y: #{y} value: #{value} \n"
	end

	def <=>(other)
		return [y,x] <=> [other.y, other.x]
	end
end

class Part1
	def initialize(file_name)
		@height = nil
		@width = nil
		@map = {}
		process_file(file_name)
		move
		print_map
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
				@map[[x,y]] = Node.new(x, y, input[y][x])
			end
		end
	end

	def move
# x: 21 y: 4 value: G 
# x: 25 y: 9 value: E 
		find_shortest_path(@map[[21,4]], @map[[25,9]])
	end

	def find_shortest_path(start, goal)
		frontier = Queue.new(start)
		#visited = {}
		#visited[start] = true
		came_from = {}
		came_from[start] = nil

		while !frontier.empty?
		   	current = frontier.remove
		   	get_neighbors(current).each do |neighbor|
		   		# if !visited[neighbor] 
		   		# 	frontier.add(neighbor)
		   		# 	visited[neighbor] = true	
		   		# end
		   		if !came_from[neighbor]
		   			frontier.add(neighbor)
		   			came_from[neighbor] = current
		   		end
		   	end
		end
		current = goal 
		path = []
		while current != start && current != nil
			path.push(current)
			current = came_from[current]
		end
		puts path
	end

	def get_neighbors(node)
		neighbors = []
		if valid_move(node.x + 1, node.y)
			neighbors.push(@map[[node.x + 1, node.y]])
		end
		if valid_move(node.x - 1, node.y)
			neighbors.push(@map[[node.x - 1, node.y]])
		end
		if valid_move(node.x, node.y + 1)
			neighbors.push(@map[[node.x, node.y + 1]])
		end
		if valid_move(node.x, node.y - 1)
			neighbors.push(@map[[node.x, node.y - 1]])
		end
		return neighbors
	end

	def valid_move(x, y)
		return x > -1 && x < @width && 
				y > -1 && y < @height &&
				@map[[x,y]].value == "."
	end
end

Part1.new("input.txt")
