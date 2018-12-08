# susan evans
# last edited 12/07/2018
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
		processFile(file_name)
		@pos = 2
		build_tree(Node.new(@data[0], @data[1]))
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
		while node.children != 0
			@pos += 2
			node.children -= 1
			build_tree(Node.new(@data[@pos - 2], @data[@pos - 1]))
		end
		for i in 0...node.metadata
			@sum += @data[@pos]
			@pos += 1
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
