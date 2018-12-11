# susan evans
# last edited 12/11/2018
# advent of code 2018, day 11, part 1

class Part1
	def initialize(file_name)
		@serial_number = 5153
		@grid = {}
		@three_by_sums = {}
		fill_grid
		find_all_three_by_three_sums
		output
	end

	def find_power_level(x, y)
		rack_ID = x + 10
		power = ((rack_ID * y + @serial_number) * rack_ID) / 100 % 10 - 5
		return power
	end

	def fill_grid
		for y in 1..300
			for x in 1..300
				@grid[[x,y]] = find_power_level(x, y)
			end
		end
	end

	def sum_three_by_three_grid(x, y)
		sum = 0
		for col in y...(y+3)
			for row in x...(x+3)
				sum += @grid[[row,col]]
			end
		end
		@three_by_sums[[x,y]] = sum
	end

	def find_all_three_by_three_sums
		for y in 1..(298)
			for x in 1..(298)
				sum_three_by_three_grid(x, y)
			end
		end
	end

	def output
		puts "#{@three_by_sums.max_by{|k,v| v}}"
	end
end

Part1.new("input.txt")

