# susan evans
# last edited 12/05/2017
# advent of code 2017, day 6, part 1

class Part1
	def initialize(file_name)
		@count = 0
		@configs = []
		@banks = nil
		processFile(file_name)
		count_banks
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@banks = line.split(" ").map(&:to_i)
			end
		end
	end

	def count_banks
		while @configs.index(@banks.to_s) == nil
			@configs.push(@banks.to_s)
			pos = @banks.index(@banks.max)
			blocks = @banks[pos]
			@banks[pos] = 0
			while blocks > 0
				pos = (pos + 1) % @banks.length
				@banks[pos] += 1
				blocks -= 1
			end
			@count += 1
		end
	end

	def output
		puts "#{@count}"
	end
end

Part1.new("input.txt")