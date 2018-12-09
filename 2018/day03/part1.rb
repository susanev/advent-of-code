# susan evans
# last edited 12/03/2018
# advent of code 2018, day 3, part 1

class Part1
	def initialize(file_name)
		@area = {}
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				process(line.scan(/\d+/).map(&:to_i))
			end
		end
	end

	def process(line)
		# id, left, top, width, height
		for i in line[1]...(line[1]+line[3])
			for j in line[2]...(line[2]+line[4])
				if @area[[i,j]]
					@area[[i,j]] = "X"
				else
					@area[[i,j]] = line[0]
				end
			end
		end
	end

	def output
		puts "#{@area.values.count("X")}"
	end
end

Part1.new("input.txt")
