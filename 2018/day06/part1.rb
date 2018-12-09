# susan evans
# last edited 12/06/2018
# advent of code 2018, day 6, part 1

class Part1
	def initialize(file_name)
		@posis = []
		@max_x = 0
		@max_y = 0
		@coords = {}
		@grid = {}
		processFile(file_name)
		markUp
		# printGrid
		remove
		output
	end

	def processFile(file_name)
		i = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.strip!
				vals = line.scan(/\d+/).map(&:to_i)
				@max_x = [@max_x, vals[0]].max 
				@max_y = [@max_y, vals[1]].max
				@coords[vals] = i.to_s
				@posis.push(i.to_s)
				i += 1
			end
		end
	end

	def printGrid
		for i in 0..@max_y
			for j in 0..@max_x
				print @grid[[j,i]]
			end
			print "\n"
		end
	end

	def markUp
		for i in 0..@max_y
			for j in 0..@max_x
				if @coords[[j,i]] == nil
					@grid[[j, i]] = findClosest(j, i)
				else
					@grid[[j,i]] = @coords[[j,i]]
				end
			end
		end
	end

	def findClosest(j, i)
		dists = {}
		@coords.each do |k,v|
			dists[v] = manhattan(j, i, k[0], k[1])
		end

		vals = dists.values
		min = vals.min
		if vals.count(min) == 1
			return dists.key(min).downcase
		else
			return "."
		end
	end

	def remove
		cands = []
		for i in 0..@max_x
			cands.push(@grid[[i, 0]])
			cands.push(@grid[[i, @max_y]])
		end
		for i in 0..@max_y
			cands.push(@grid[[0,i]])
			cands.push(@grid[[@max_x, i]])
		end
		rem = cands.uniq
		rem.each do |thing|
			@posis.delete(thing)
		end
	end


	def manhattan(x,y,a,b)
		return (x - a).abs + (y - b).abs
	end


	def output
		max = 0
		@posis.each do |ohmy|
			max = [@grid.values.count(ohmy), max].max
		end
		puts max
	end
end

Part1.new("input.txt")