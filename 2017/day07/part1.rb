# susan evans
# last edited 12/06/2017
# advent of code 2017, day 7, part 1

class Part1
	def initialize(file_name)
		@keys = []
		@vals = []
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				if !line.index("->").nil?
					@keys.push(line[/[a-z]+/])
					line[line[/[a-z]+[\s(\d*)]/].length + 
								line[/\d+/].length + 
								6...line.length].split(", ").each do |item|
						@vals.push(item)
					end
				end
			end
		end
	end

	def output
		@keys.each do |key|
			if @vals.index(key).nil?
				puts key
			end
		end
	end
end

Part1.new("input.txt")