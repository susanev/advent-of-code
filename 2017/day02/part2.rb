class Part2
	def initialize(file_name)
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				row = line.split(" ").map(&:to_i)
				@sum += process(row)
			end
		end
	end

	def process(row)
		(row.length - 1).times do |index1|
			((index1 + 1)..row.length - 1).each do |index2|
				if row[index1] % row[index2] == 0
					return row[index1] / row[index2]
				end
				if row[index2] % row[index1] == 0
					return row[index2] / row[index1]
				end
			end
		end
	end

	def output
		puts "#{@sum}"
	end
end

Part2.new("input.txt")