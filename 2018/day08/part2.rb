# susan evans
# last edited 12/08/2018
# advent of code 2018, day 8, part 2

class Node
	attr_accessor :children_to_process, :metadata_cnt, :value,
		:children, :metadata

	def initialize(children, metadata)
		@children_to_process = children
		@metadata_cnt = metadata
		@children = []
		@metadata = []
	end
end

class Part2
	def initialize(file_name)
		@data = []
		@pos = 2
		@sum = 0
		processFile(file_name)
		@root = Node.new(@data[0], @data[1])
		build_tree(@root)
		find_root_sum
		output
	end

	def processFile(file_name)
		@data = File.open(file_name, "r").
				readlines[0].split(" ").map(&:to_i)
	end

	def build_tree(node)
		while node.children_to_process != 0
			@pos += 2
			node.children_to_process -= 1
			child_node = Node.new(@data[@pos - 2], 
					@data[@pos - 1])
			node.children.push(child_node)
			build_tree(child_node)
		end
		node.metadata_cnt.times do
			node.metadata.push(@data[@pos])
			@pos += 1
		end
	end

	def find_root_sum
		found = {}
		@root.metadata.each do |child|
			if child <= @root.children.length
				@sum += find_node_sum(@root.children[child - 1])
			end
		end
	end

	def find_node_sum(node)
		if node.children.length == 0
			return node.metadata.reduce(&:+)
		else
			sum = 0
			node.metadata.each do |ind|
				if ind <= node.children.length
					sum += find_node_sum(node.children[ind - 1])
				end
			end
			return sum
		end
	end

	def output
		 puts "#{@sum}"
	end
end

Part2.new("input.txt")
