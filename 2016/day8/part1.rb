# susan evans
# last edited 12/08/2016
# advent of code 2016, day 8, part 1
# processes a file to count the number
# of lights in a grid

class Part1
	def initialize(file_name)
		@lights = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				# scans file for rect and adds to @lights
				if line.include? "rect"
					@lights += line[/(?<=rect )\d+/].to_i * line[/(?<=x)\d+/].to_i
				end
			end
		end
	end

	# displays the number of lit lights
	def output
		puts "#{@lights} lights are lit"
	end
end

Part1.new("input.txt")