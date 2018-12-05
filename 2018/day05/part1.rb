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
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@data = line.strip.split("")
			end
		end
	end

	def process
		prev_data = []
		while !prev_data.eql?(@data)
			i = 0
			prev_data = @data.clone
			while i < @data.length - 1
				if @data[i].downcase.eql?(@data[i+1].downcase) &&
						!@data[i].eql?(@data[i+1])
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