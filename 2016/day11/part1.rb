# susan evans
# last edited 12/10/2016
# advent of code 2016, day 11, part 1

class Part1
	def initialize(file_name)
		base = "BB "*15
		@grid = Array.new(4)
		4.times do |i|
			@grid[i] = base.split(" ")
		end
		@grid[3][0] = "EE"
		@grid[3][1] = "1G"
		@grid[3][2] = "1M"
		@grid[3][3] = "2G"
		@grid[3][4] = "2M"
		@grid[3][5] = "3G"
		@grid[3][6] = "3M"
		@grid[2][7] = "4G"
		@grid[1][8] = "4M"
		@grid[2][9] = "5G"
		@grid[1][10] = "5M"
		@grid[2][11] = "6G"
		@grid[1][12] = "6M"
		@grid[2][13] = "7G"
		@grid[1][14] = "7M"

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
		@grid.each do |row|
			row.each do |item|
				print item + " "
			end
			print "\n"
		end
	end
end

Part1.new("input.txt")
