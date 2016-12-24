# susan evans
# last edited 12/23/2016
# advent of code 2016, day 24, part 1

class Part1
	def initialize(file_name)
		process_file(file_name)	
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def build_instruction(line)
		instr = {}
		instr[:type] = line[0].to_sym
		(1..CONST_MAX_INPUTS).each do |i|
			instr[i] = convert(line[i]) if line[i]
		end
		@instructions.push(instr)
	end

	def output
		puts ""
	end
end

Part1.new("input.txt")