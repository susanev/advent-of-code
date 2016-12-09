# susan evans
# last edited 12/08/2016
# advent of code 2016, day 9, part 1

class Part1
	def initialize(file_name)
		@lights = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def output
		puts "#{@lights} lights are lit"
	end
end

Part1.new("input.txt")