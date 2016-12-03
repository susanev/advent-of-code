class Part1
	def initialize(file_name)

		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp.split("").each do |instr|
					process(instr)
				end
			end
		end
	end

	def process(instr)

	end

	def output

	end
end

Part1.new("input.txt")