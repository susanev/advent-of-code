class Part1
	def initialize(file_name)
		@keypad = {
			1 => [-1, 1], 
			2 => [0, 1], 
			3 => [1, 1], 
			4 => [-1, 0], 
			5 => [0, 0], 
			6 => [1, 0], 
			7 => [-1, -1], 
			8 => [0, -1], 
			9 => [1, -1]
		}
		@position = [0, 0]
		@code = ""
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp.split("").each do |instr|
					process(instr)
				end
				@code += @keypad.key(@position).to_s
			end
		end
	end

	def process(instr)
		case instr
		when "U"
			@position[1] = [1, @position[1] + 1].min
		when "R"
			@position[0] = [1, @position[0] + 1].min
		when "D"
			@position[1] = [-1, @position[1] - 1].max
		when "L"
			@position[0] = [-1, @position[0] - 1].max
		end
	end

	def output
		puts "the bathroom code is #{@code}"
	end
end

Part1.new("input.txt")