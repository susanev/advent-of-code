# susan evans
# last edited 12/19/2016
# advent of code 2016, day 20, part 1

class Part1
	def initialize(file_name)
		@lines = process_file(file_name)
		@lowest = find_lowest
		output
	end

	def process_file(file_name)
		lines = []
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				min = line[/\d+/].to_i
				max = line[/\d+$/].to_i
				lines.push({min: min,max: max})
			end
		end
		lines.sort! { |x,y| x[:min] <=> y[:min] }
	end

	def find_lowest
		lowest = nil
		pos = 0
		while !lowest && pos < @lines.length - 1
			curr_range = @lines[pos]
			next_range = @lines[pos + 1]
			if curr_range[:max] + 1 == next_range[:min]
				curr_range[:max] = next_range[:max]
				@lines.delete_at(pos + 1)
			elsif curr_range[:max] > next_range[:min] 
				if curr_range[:max] < next_range[:max] 
					curr_range[:max] = next_range[:max]
				end
				@lines.delete_at(pos + 1)
			else
				lowest = curr_range[:max] + 1
			end
		end
		return lowest
	end

	def output
		puts "The lowest-valued IP is #{@lowest}"
	end
end

Part1.new("input.txt")