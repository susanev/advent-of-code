

# susan evans
# last edited 12/13/2017
# advent of code 2017, day 14, part 1

#85558

class Part1
	def initialize(file_name)
		val = -1
		@width = 4
		@grid = []
		@list = Array.new(256) {val += 1}
		@lengths = []
		@current = 0
		@skip_size = 0
		@dense = []
		@used = 0
		processFile(file_name)
		@output = ""
		@grid = "##...#.##.###...".split("")
		assign
		@all_groups = []
		@programs = {}
		@count = 0
		processString
		count_programs
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
			end
			if connections.length > 0
				@output += item_index.to_s + " <-> " + connections.join(", ") + "\n"
			end
		end
		puts @output
	end

# 0 <-> 412, 480, 777, 1453
# 1 <-> 132, 1209
# 2 <-> 1614
# 3 <-> 3
# 4 <-> 1146
# 5 <-> 5, 528
# 6 <-> 107, 136, 366, 1148, 1875
# 7 <-> 452, 701, 1975
# 8 <-> 164
# 9 <-> 912, 920

	def processString
		@output.each_line do |line|
			line.chomp!
			prog = line[/\d+\s/].to_i
			arrow_index = line.index("<->")
			to = line[arrow_index + 4..line.length].split(",").map(&:to_i)
			@programs[prog] = to
		end
	end

	def count_programs
		12.times do |n|
			if !@all_groups.include?(n)
				@connections = [n]
				process2(n)
				@all_groups.push(*@connections)
				@count += 1
			end
			print @programs
		end
	end

	def process2(n)
		prev = nil
		while prev != @connections.sort.to_s
			prev = @connections.clone.sort.to_s
			@programs.clone.each do |prog, to|
				if prog == n
					to.each do |val|
						@connections.push(val)
						@programs.delete(prog)
					end
				elsif to.include?(n)
					@connections.push(prog)
					@programs.delete(prog)
				else
					to.each do |val|
						if @connections.include?(val)
							@connections.push(prog)
							@programs.delete(prog)
						end
					end
				end
			end
			@connections.uniq!
		end
	end

	def output
		puts "#{@count}"
	end
end

Part1.new("input.txt")

