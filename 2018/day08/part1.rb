# susan evans
# last edited 12/08/2018
# advent of code 2018, day 8, part 1

class Node
	attr_accessor :children, :metadata

	def initialize(children, metadata)
		@children = children
		@metadata = metadata
	end
end

class Part1
	def initialize(file_name)
		@data = []
		@sum = 0
		@pos = 2
		processFile(file_name)
		build_tree(Node.new(@data[0], @data[1]))
		output
	end

	def processFile(file_name)
		@data = File.open(file_name, "r").
				readlines[0].split(" ").map(&:to_i)
	end

	def build_tree(node)
		while node.children != 0
			@pos += 2
			node.children -= 1
			build_tree(Node.new(@data[@pos - 2], @data[@pos - 1]))
		end
		@sum += @data[@pos...(node.metadata + @pos)].reduce(&:+)
		@pos += node.metadata
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
