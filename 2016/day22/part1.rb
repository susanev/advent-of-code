# susan evans
# last edited 12/23/2016
# advent of code 2016, day 22, part 1

class Part1
	def initialize(file_name)
		@viable_pairs = []
		@data = []
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				if line.include? "/dev/grid/node"
					add_data(line)
				end
			end
		end
	end

	def add_data(line)
		line = line.split(" ").map(&:to_i)
		new_data = {used: line[2], avail: line[3]}
		count_viable_pairs(new_data)
		@data.push(new_data)
	end

	def count_viable_pairs(d2)
		@data.each_with_index do |d1, i|
			if d1[:used] != 0 && d1[:used] <= d2[:avail]			
				@viable_pairs.push([d1, d2])
			elsif d2[:used] != 0 && d2[:used] <= d1[:avail]
				@viable_pairs.push([d2, d1])
			end
		end
	end

	def output
		puts "There are #{@viable_pairs.length} viable pairs"
	end
end

Part1.new("input.txt")