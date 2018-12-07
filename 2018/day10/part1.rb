# susan evans
# last edited 12/09/2017
# advent of code 2017, day 10, part 1

class Part1
	def initialize(file_name)
		val = -1
		@list = Array.new(256) {val += 1}
		@lengths = []
		@current = 0
		@skip_size = 0
		processFile(file_name)
		process
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lengths = line.split(",").map(&:to_i)
			end
		end
	end

	def process
		@lengths.each do |length|
			if length <= @list.length
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

	def output
		puts "#{@list[0] * @list[1]}"
	end
end

Part1.new("input.txt")
