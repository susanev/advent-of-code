# susan evans
# last edited 12/09/2017
# advent of code 2017, day 10, part 2

class Part2
	def initialize(file_name)
		val = -1
		@list = Array.new(256) {val += 1}
		@lengths = []
		@current = 0
		@skip_size = 0
		@dense = []
		processFile(file_name)
		process
		create_dense
		convert_to_hex
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lengths = line.split("").map(&:ord)
				@lengths.push(17, 31, 73, 47, 23)
			end
		end
	end

	def process
		64.times do
			@lengths.each do |length|
				if length <= @list.length
					insert_sub(build_sub(length))
					@current = (@current + length + @skip_size) % @list.length
					@skip_size += 1
				end
			end
		end
	end

	def build_sub(length)
		sub = []
		length.times do |pos|
			sub.push(@list[(@current + pos) % @list.length])
		end
		return sub.reverse
	end

	def insert_sub(sub)
		sub.each_with_index do |item, item_index|
			@list[(@current + item_index) % @list.length] = item
		end
	end

	def create_dense
		pos = 0
		(@list.length / 16).times do
			xor = @list[pos]
			15.times do
				xor = xor ^ @list[pos + 1]
				pos += 1
			end
			pos += 1
			@dense.push(xor)
		end
	end

	def convert_to_hex
		@dense.each_with_index do |item, item_index|
			@dense[item_index] = item.to_s(16)
			if @dense[item_index].length == 1
				@dense[item_index] = "0" + @dense[item_index]
			end
		end
	end

	def output
		puts "#{@dense.join}"
	end
end

Part2.new("input.txt")
