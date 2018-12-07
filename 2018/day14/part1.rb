# susan evans
# last edited 12/13/2017
# advent of code 2017, day 14, part 1

class Part1
	def initialize(file_name)
		val = -1
		@list = Array.new(256) {val += 1}
		@lengths = []
		@current = 0
		@skip_size = 0
		@dense = []
		@used = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				line += "-"
				each(line)
			end
		end
	end

	def each(line)
		(0..127).each do |n|
			new_line = line + n.to_s
			val = -1
			@list = Array.new(256) {val += 1}
			@skip_size = 0
			@current = 0
			@lengths = (new_line.split("")).map(&:ord)
			@lengths.push(17, 31, 73, 47, 23)
			process
			create_dense
			convert_to_hex
			count_used
		end
	end

	def process
		64.times do
			@lengths.each do |length|
				insert_sub(build_sub(length))
				@current = (@current + length + @skip_size) % @list.length
				@skip_size += 1
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
		@dense = []
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

	def count_used
		@dense.each  do |item|
			@used += item.hex.to_s(2).rjust(item.size*4, '0').count("1")
		end
	end

	def output
		puts "#{@used}"
	end
end

Part1.new("input.txt")

