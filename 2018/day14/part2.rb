# susan evans
# last edited 12/14/2017
# advent of code 2017, day 14, part 2

class Part2
	def initialize(file_name)
		val = -1
		@width = 128
		@grid = []
		@list = Array.new(256) {val += 1}
		@lengths = []
		@current = 0
		@skip_size = 0
		@dense = []
		@programs = {}
		processFile(file_name)
		assign
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
		row = ""
		@dense.each  do |item|
			row += item.hex.to_s(2).rjust(item.size*4, '0')
		end
		row = row.split("")
		row.each_with_index do |item, item_index|
			if item == "1"
				row[item_index] = "#"
			else
				row[item_index] = "."
			end
		end
		@grid.push(row)
		@grid.flatten!
	end

	def assign
		@grid.each_with_index do |item, item_index|
			connections = []
			if item == "#"
				if (item_index + 1) % @width != 0 && @grid[item_index + 1] == "#"
					connections.push(item_index + 1)
				end
				if (item_index % @width) != 0 && @grid[item_index - 1] == "#"
					connections.push(item_index - 1)
				end
				if (item_index - @width) > -1 && @grid[item_index - @width] == "#"
					connections.push(item_index - @width)
				end
				if (item_index + @width) < @width * @width && @grid[item_index + @width] == "#"
					connections.push(item_index + @width)
				end
				if !update(item_index, connections)
					@programs[item_index] = connections
				end
			end
		end
	end

	def update(val, connections)
		added = false
		@programs.each do |prog, to|
			if to.include?(val) || !(to & connections).empty?
				@programs[prog].push(connections)
				@programs[prog].flatten!
				@programs[prog].uniq!
				remove_dups(prog, val)
				return true
			end
		end
		return false
	end

	def remove_dups(prog, val)
		remove_indexs = []
		@programs.each do |prog2, to2|
			if prog != prog2 && to2.include?(val)
				@programs[prog].push(to2)
				@programs[prog].push(prog2)
				@programs[prog].flatten!
				@programs[prog].uniq!
				remove_indexs.push(prog2)
			end
		end
		remove_indexs.each do |prog|
			@programs.delete(prog)
		end
	end

	def output
		puts @programs.length 
	end

end

Part2.new("input.txt")
