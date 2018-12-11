# susan evans
# last edited 12/11/2018
# advent of code 2018, day 11, part 1

class Part1
	def initialize(file_name)
		@serial_number = 5153
		@grid = {}
		@sums = {}
		fill_grid
		for i in 1..300
			find_sums(i)
			output
		end
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

	# def find_greatest_sum

	# end

	def sum_any_grid(x, y, size)
		sum = 0
		for col in y...(y+size)
			for row in x...(x+size)
				sum += @grid[[row,col]]
			end
		end
		@sums[[x,y]] = sum
	end

	def find_sums(size)
		for y in 1..(301 - size)
			for x in 1..(301 - size)
				sum_any_grid(x, y, size)
			end
		end
	end

	def output
		puts "#{@sums.max_by{|k,v| v}}"
	end
end

Part1.new("input.txt")

