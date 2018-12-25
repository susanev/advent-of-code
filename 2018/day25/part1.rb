# susan evans
# last edited 12/25/2018
# advent of code 2018, day 25, part 1

class Constellation
	attr_accessor :points

	def initialize(pt)
		@points = [pt]
	end
end

class Part1
	def initialize(file_name)
		@points = []
		@constellations = []
		process_file(file_name)
		find_constellations
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@points.push(line.split(",").map(&:to_i))
			end
		end
	end

	def find_constellations
		while @points != []
			@constellations.push(Constellation.new(@points.pop))

			change = true
			while change
				change = false
				i = 0
				while i < @points.length
					if check_point(i)
						change = true
						i -= 1
					end
					i += 1
				end
			end
		end
	end

	def check_point(point_index)
		@constellations.each do |constellation|
			constellation.points.each do |const_point|
				if manhattan_distance(@points[point_index], const_point) <= 3
					constellation.points.push(@points[point_index])
					@points.delete_at(point_index)
					return true
				end
			end
		end
		return false
	end

	def manhattan_distance(a,b)
		sum = 0
		for i in 0...4
			sum += (a[i] - b[i]).abs
		end
		return sum
	end

	def output
		puts "#{@constellations.length}"
	end
end

Part1.new("input.txt")
