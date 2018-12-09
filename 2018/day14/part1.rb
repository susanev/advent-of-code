# susan evans
# last edited 12/14/2018
# advent of code 2018, day 14, part 1

class Part1
	def initialize(file_name)
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
