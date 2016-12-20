# susan evans
# last edited 12/19/2016
# advent of code 2016, day 20, part 2

class Part2
	def initialize(file_name)
		@lines = process_file(file_name)
		reduce_lines
		@allowed_ips = count_valid_ips
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

	def reduce_lines
		pos = 0
		while pos < @lines.length - 1
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
				pos += 1
			end
		end
	end

	def count_valid_ips
		allowed_ips = 0
		(0...@lines.length - 1).each do |pos|
			allowed_ips += @lines[pos + 1][:min] - @lines[pos][:max] - 1
		end
		return allowed_ips
	end

	def output
		puts "There are #{@allowed_ips} allowed ips"
	end
end

Part2.new("input.txt")