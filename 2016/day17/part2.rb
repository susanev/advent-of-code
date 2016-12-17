# susan evans
# last edited 12/16/2016
# advent of code 2016, day 17, part 2

class Part2
	require 'digest/md5'

	CONST_GOAL = [3, 3]
	CONST_WIDTH = 4
	CONST_HEIGHT = 4
	CONST_VALID = "bcdef"

	  def initialize(file_name)
		@code = File.open(file_name, "r").first
		@longest = 0
		find_longest_path
		output
	  end

	def find_longest_path
		locations = [{dirs: "", loc: [0, 0]}]
		until locations.empty?
			location = locations.pop	  
			get_neighbors(location[:dirs], location[:loc][0], location[:loc][1]).each do |neighbor|
				if neighbor[:loc] == CONST_GOAL
					@longest = [@longest, neighbor[:dirs].length].max
				else
					locations.push(neighbor)
				end
			end
		end
	end

	def get_neighbors(dirs, x, y)
		neighbors = []
		code = Digest::MD5.hexdigest("#{@code}#{dirs}")[0, 4]
		if y > 0 && state(code[0]) == :open
			neighbors.push({dirs: dirs + "U", loc: [x, y - 1]})
		end
		if y < CONST_HEIGHT - 1 && state(code[1]) == :open
			neighbors.push({dirs: dirs + "D", loc: [x, y + 1]})
		end
		if x > 0 && state(code[2]) == :open
			neighbors.push({dirs: dirs + "L", loc: [x - 1, y]})
		end
		if x < CONST_WIDTH - 1 && state(code[3]) == :open
			neighbors.push({dirs: dirs + "R", loc: [x + 1, y]})
		end
		return neighbors
	end

	def state(str)
		return CONST_VALID.include?(str) ? :open : :closed
	end

	def output
		puts "The length of the longest path is: #{@longest}"
	end
end

Part2.new("input.txt")
