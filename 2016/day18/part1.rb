# susan evans
# last edited 12/17/2016
# advent of code 2016, day 18, part 1

class Part1
	def initialize(file_name)
		process_file
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def output
		puts ""
	end
end

Part1.new("input.txt")
