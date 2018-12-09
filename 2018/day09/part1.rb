# susan evans
# last edited 12/09/2018
# advent of code 2018, day 9, part 1

class List
	attr_accessor :start_node, :curr_node

	def initialize(start_node, curr_node)
		@start_node = start_node
		@curr_node = curr_node
	end
end

class Node
	attr_accessor :value, :next_node, :prev_node

	def initialize(value, next_node, prev_node)
		@value = value
		@next_node = next_node
		@prev_node = prev_node
	end
end

class Part1
	def initialize(file_name)
		@curr_player = 2
		processFile(file_name)
		initalize_list
		playGame
		output
	end

	def processFile(file_name)
		@players, @total_marbles = File.open(file_name, "r").
				readlines[0].scan(/\d+/).map(&:to_i)
		@scores = Array.new(@players, 0)
	end

	def initalize_list
		@curr_marble = 1

		start_node = Node.new(0, nil, nil)
		start_node.next_node = start_node
		start_node.prev_node = start_node
		@list = List.new(start_node, start_node)
	end

	def playGame
		while @curr_marble < @total_marbles
			if @curr_marble % 23 == 0
				@list.curr_node = @list.curr_node.prev_node.prev_node.prev_node.
						prev_node.prev_node.prev_node.prev_node

				@scores[@curr_player] += @curr_marble +
							@list.curr_node.value

				save = @list.curr_node.next_node			
				@list.curr_node.prev_node.next_node = @list.curr_node.next_node
				@list.curr_node.next_node.prev_node = @list.curr_node.prev_node
				@list.curr_node = save
			else
				@list.curr_node = @list.curr_node.next_node
				new_node = Node.new(@curr_marble, @list.curr_node.next_node,
						@list.curr_node)
				@list.curr_node.next_node = new_node
				@list.curr_node = new_node
				new_node.next_node.prev_node = new_node
			end

			@curr_marble += 1
			@curr_player= (@curr_player + 1) % @players
		end
	end

	def output
		puts "#{@scores.max}"
	end
end

Part1.new("input.txt")
