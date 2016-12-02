class Part2
	def initialize(file_name)
		@keypad = {
			1 => [0, 2], 
			2 => [-1, 1], 
			3 => [0, 1], 
			4 => [1, 1], 
			5 => [-2, 0], 
			6 => [-1, 0], 
			7 => [0, 0], 
			8 => [1, 0], 
			9 => [2, 0], 
			:A => [-1, -1], 
			:B => [0, -1], 
			:C => [1, -1], 
			:D => [0, -2]
		}
		@position = [-2, 0]
		@code = ""
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				data = line.chomp.split("")
				data.each do |instr|
					process(instr)
				end
				@code += @keypad.key(@position).to_s
			end
		end
	end

	def process(instr)
		case instr
		when "U"
			if !@keypad.key([@position[0], @position[1] + 1]).nil?
				@position[1] = @position[1] + 1
			end
		when "R"
			if !@keypad.key([@position[0] + 1, @position[1]]).nil?
				@position[0] = @position[0] + 1
			end
		when "D"
			if !@keypad.key([@position[0], @position[1] - 1]).nil?
				@position[1] = @position[1] - 1
			end
		when "L"
			if !@keypad.key([@position[0] - 1, @position[1]]).nil?
				@position[0] = @position[0] - 1
			end
		end
	end

	def output
		puts "the bathroom code is #{@code}"
	end
end

Part2.new("input.txt")