# susan evans
# last edited 12/03/2017
# advent of code 2015, day 9, part 1

class Part1
	def initialize(file_name)
		@data = []
		@locs = []
		@dists = []
		process_file(file_name)
		find_dists
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				to = /to/ =~ line
				equals = /=/ =~ line
				@data.push({start: line[0...to - 1],
						end: line[to + 3...equals - 1],
						dist: line[equals + 2...line.length].to_i})
				if @locs.index(line[0...to - 1]).nil?
					@locs.push(line[0...to - 1])
				end
				if @locs.index(line[to + 3...equals - 1]).nil?
					@locs.push(line[to + 3...equals - 1])
				end
			end
		end
		@locs = @locs.permutation.to_a
	end

	def find_dists
		@locs.each do |path|
			dist = 0
			(0...path.length - 1).each do |elem|
				@data.each do |dat|
					if (dat[:start] == path[elem] && dat[:end] == path[elem + 1]) ||
						(dat[:end] == path[elem] && dat[:start] == path[elem + 1])
						dist += dat[:dist]
					end
				end
			end
			@dists.push(dist)
		end
	end

	def output
		puts @dists.min
	end

end

Part1.new("input.txt")