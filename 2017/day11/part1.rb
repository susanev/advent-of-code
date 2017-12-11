# susan evans
# last edited 12/10/2017
# advent of code 2017, day 11, part 1

class Part1
	def initialize(file_name)
		@dirs = []
		@counts = {n: 0, ne: 0, se: 0, s: 0, sw: 0, nw: 0}
		@dif_pairs = [[:ne, :sw], [:ne, :sw], [:nw, :se], [:n, :s]]
		@red_pairs = [[:se, :sw, :s], [:ne, :nw, :n], [:ne, :s, :se],
						[:sw, :n, :nw], [:n, :se, :ne]]
		@sum = 0
		processFile(file_name)
		count
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@dirs = line.split(",")
			end
		end
	end

	def count
		@dirs.each do |dir|
			@counts[dir.to_sym] += 1
		end
		calc_dif_pairs
		reduce_dif_pairs
		@counts.values.each { |val| @sum += val}
	end

	def calc_dif_pairs
		@dif_pairs.each do |pair|
			diff = (@counts[pair[0]] - @counts[pair[1]]).abs
			if @counts[pair[0]] > @counts[pair[1]]
				@counts[pair[0]] = diff
				@counts[pair[1]] = 0
			else
				@counts[pair[1]] = diff
				@counts[pair[0]] = 0
			end
		end
	end

	def reduce_dif_pairs
		@red_pairs.each do |pair|
			if @counts[pair[0]] != 0 && @counts[pair[1]] != 0
				if @counts[pair[0]] > @counts[pair[1]]
					@counts[pair[0]] -= @counts[pair[1]]
					@counts[pair[2]] += @counts[pair[1]]
					@counts[pair[1]] = 0
				else 
					@counts[pair[1]] -= @counts[pair[0]]
					@counts[pair[2]] += @counts[pair[0]]
					@counts[pair[0]] = 0
				end
			end
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part1.new("input.txt")
