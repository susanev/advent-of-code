class Part1
	def initialize(file_name)
		@position = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				instrs = line.split("").map { |i| i == '(' ? 1 : -1 }
				floor = 0
				until floor == -1 || @position >= instrs.length
					floor += instrs[@position]
					@position += 1
				end
			end
		end
	end

	def output
		puts "position #{@position}"
	end
end

Part1.new("input.txt")