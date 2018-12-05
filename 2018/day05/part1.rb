# susan evans
# last edited 12/04/2018
# advent of code 2018, day 5, part 1

class Part1
	def initialize(file_name)
		@data = []
		processFile(file_name)
		process
		output
	end

	def processFile(file_name)
		@data= File.open(file_name, "r").
				readlines[0].split("")
	end

	def process
		prev_length = 0
		while prev_length != @data.length
			i = 0
			prev_length = @data.length
			while i < @data.length - 1
				if (@data[i].ord - @data[i + 1].ord).abs - 32 == 0
					@data.delete_at(i)
					@data.delete_at(i)
				end
				i += 1
			end
		end
	end

	def output
		puts "#{@data.length}"
	end
end

Part1.new("input.txt")