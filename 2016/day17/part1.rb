# susan evans
# last edited 12/17/2016
# advent of code 2016, day 17, part 1

class Part1
	require 'digest/md5'

	CONST_GOAL = [3, 3]
	CONST_WIDTH = 4
	CONST_HEIGHT = 4
	CONST_VALID = "bcdef"
	CONST_DIRECTIONS = {0 => {dir: "U", trf: [0, -1]},
											1 => {dir: "D", trf: [0, 1]},
											2 => {dir: "L", trf: [-1, 0]},
											3 => {dir: "R", trf: [1, 0]}}

	def initialize(file_name)
		@code = File.open(file_name, "r").first
		@shortest = find_shortest_path
		output
	end

	def find_shortest_path
		locations = [{dirs: "", loc: [0, 0]}]
		until locations.empty?
			location = locations.pop	  
			get_neighbors(location).each do |neighbor|
				if neighbor[:loc] == CONST_GOAL
					return neighbor[:dirs]
				else
					locations.push(neighbor)
				end
			end
		end
	end

	def get_neighbors(location)
		dirs = location[:dirs]
		neighbors = []
		code = Digest::MD5.hexdigest("#{@code}#{dirs}")[0, 4]
		CONST_DIRECTIONS.each do |k, v|
			new_loc = [location[:loc][0] + v[:trf][0], location[:loc][1] + v[:trf][1]]
			if valid_move(new_loc[0], new_loc[1], code[k]) 
				neighbors.push({dirs: dirs + v[:dir], loc: new_loc})
			end
		end
		return neighbors
	end

	def valid_move(x, y, str)
    x > -1 && x < CONST_WIDTH && 
    	y > -1 && y < CONST_HEIGHT &&
    	CONST_VALID.include?(str) 
	end

	def output
		puts "The shortest path is: #{@shortest}"
	end
end

Part1.new("input.txt")
