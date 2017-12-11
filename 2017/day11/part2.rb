# susan evans
# last edited 12/10/2017
# advent of code 2017, day 11, part 2

class Part2
	def initialize(file_name)
		@dirs = []
		@counts = {n: 0, ne: 0, se: 0, s: 0, sw: 0, nw: 0}
		@dif_pairs = [[:ne, :sw], [:ne, :sw], [:nw, :se], [:n, :s]]
		@red_pairs = [[:se, :sw, :s], [:ne, :nw, :n], [:ne, :s, :se],
						[:sw, :n, :nw], [:n, :se, :ne]]
		@max = 0
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
			sum = 0
			reduce_dif_pairs(calc_dif_pairs(@counts.clone)).values.
					each { |val| sum += val}
			@max = [@max, sum].max
		end
	end

	def calc_dif_pairs(counts)
		@dif_pairs.each do |pair|
			diff = (counts[pair[0]] - counts[pair[1]]).abs
			if counts[pair[0]] > counts[pair[1]]
				counts[pair[0]] = diff
				counts[pair[1]] = 0
			else
				counts[pair[1]] = diff
				counts[pair[0]] = 0
			end
		end
		return counts
	end

	def reduce_dif_pairs(counts)
		@red_pairs.each do |pair|
			if counts[pair[0]] != 0 && counts[pair[1]] != 0
				if counts[pair[0]] > counts[pair[1]]
					counts[pair[0]] -= counts[pair[1]]
					counts[pair[2]] += counts[pair[1]]
					counts[pair[1]] = 0
				else 
					counts[pair[1]] -= counts[pair[0]]
					counts[pair[2]] += counts[pair[0]]
					counts[pair[0]] = 0
				end
			end
		end
		return counts
	end

	def output
		puts "#{@max}"
	end
end

Part2.new("input.txt")
