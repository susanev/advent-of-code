# susan evans
# last edited 12/14/2016
# advent of code 2016, day 15, part 1

class Part1
	def initialize(file_name)
		@discs = {}
		@time = 0
		process_file(file_name)
		find_n
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				info = line.scan(/\d+/).map(&:to_i)
				@discs[info[0]] = {:positions => info[1], :start => info[3]}
			end
		end
	end

	def find_n
		found = nil
		until found
			@time += 1
			found = true
			(1..@discs.length).each do |i|
				found = found && (@time + i + @discs[i][:start]) % @discs[i][:positions] == 0 
			end		
		end
	end

	def output
		puts "press the button at time=#{@time}"
	end
end

Part1.new("input.txt")
