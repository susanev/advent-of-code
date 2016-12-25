# susan evans
# last edited 12/24/2016
# advent of code 2016, day 25, part 1

class Part1
	CONST_MULT = [:cpy, :inc, :dec, :jnz, :dec, :jnz]
	CONST_MAX_INPUTS = 3
	CONST_PATTERN = "01010101"

	def initialize(file_name)
		@instructions = []
		@registers = {a: 1, b: 0, c: 0, d: 0}
		process_file(file_name)	
		add_mul
		output(find_a_value)
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
					build_instruction(line.split(" "))
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

	def find_a_value
		a_value = 1
		until process_instructions
			a_value += 1
			@registers = {a: a_value, b: 0, c: 0, d: 0}
		end
		return a_value
	end

	def process_instructions
		pos = 0
		out = ""
		until pos == @instructions.length
			instr = @instructions[pos]
			if instr[:type] == :mul
				@registers[instr[3]] += instr[1] * @registers[instr[2]]
			elsif instr[:type] == :cpy && !is_number?(instr[2])
				@registers[instr[2]] = is_number?(instr[1])? instr[1] : @registers[instr[1]]
			elsif instr[:type] == :inc
				@registers[instr[1]] += 1
			elsif instr[:type] == :dec
				@registers[instr[1]] -= 1
			elsif instr[:type] == :jnz
				if (is_number?(instr[1]) && instr[1] != 0) ||
						(!is_number?(instr[1]) && @registers[instr[1]] != 0 )
					inc = is_number?(instr[2]) ? instr[2] : @registers[instr[2]]
					pos += inc - 1 if (pos + inc - 1) < @instructions.length
				end
			elsif instr[:type] == :out
				out << (is_number?(instr[1])? instr[1] : @registers[instr[1]]).to_s
			end
			pos += 1

			if out == CONST_PATTERN
				return true
			elsif out != CONST_PATTERN[0, out.length]
				return false
			end
		end
		return false
	end

	# if a sequence of instructions representing multiplication
	# are found, they are replaced with a new mul instruction
	def add_mul
		pos = 0
		while pos < @instructions.length - 6
			six = @instructions[pos, 6]
			if six.map { |instr| instr[:type] } == CONST_MULT &&
					[six[0][1], six[0][2], six[1][1], six[4][1]].uniq.length == 4 &&
					[six[0][2], six[2][1], six[2][1]].uniq.length == 1 &&
					six[4][1] == six[5][1] &&
					six[3][2] == -2 && six[5][2] == -5
				@instructions[pos] = {:type => :mul, 1 => six[0][1], 2 => six[4][1], 3 => six[1][1]}
				@instructions[pos + 1] = {:type => :cpy, 1 => 0, 2 => six[2][1]}
				@instructions[pos + 2] = {:type => :cpy, 1 => 0, 2 => six[4][1]}
				((pos + 3)..(pos + 5)).each do |i|
					@instructions[i] = {:type => :none}
				end
			end
			pos += 1
		end
	end

	def convert(value)
		is_number?(value)? value.to_i : value.to_sym
	end

	def is_number?(value)
		true if Integer(value) rescue false
	end

	def output(str)
		puts "#{str} is the lowest positive a-value to generate #{CONST_PATTERN}"
	end
end

Part1.new("input.txt")