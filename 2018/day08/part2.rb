# susan evans
# last edited 12/07/2018
# advent of code 2018, day 8, part 2

class Node
	attr_accessor :children_cnt, :metadata_cnt, :value,
		:children, :metadata

	def initialize(children, metadata)
		@children_cnt = children
		@metadata_cnt = metadata
		@children = []
		@metadata = []
	end
end

class Part2
	def initialize(file_name)
		@data = []
		@sum = 0
		processFile(file_name)
		@pos = 2
		@root = Node.new(@data[0], @data[1])
		build_tree(@root)
		start_count
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@data = line.split(" ").map(&:to_i)
			end
		end
	end

	def build_tree(node)
		while node.children_cnt != 0
			@pos += 2
			node.children_cnt -= 1
			child_node = Node.new(@data[@pos - 2], 
					@data[@pos - 1])
			node.children.push(child_node)
			build_tree(child_node)
		end
		sum = 0
		for i in 0...node.metadata_cnt
			node.metadata.push(@data[@pos])
			@pos += 1
		end
	end

	def start_count
		@root.metadata.each do |item|
			if item <= @root.children.length
				@sum += find_sum(@root.children[item-1])
			end
		end
	end

	def find_sum(node)
		if node.children.length == 0
			return node.metadata.reduce(&:+)
		else
			sum = 0
			node.metadata.each do |ind|
				if ind <= node.children.length
					sum += find_sum(node.children[ind - 1])
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
