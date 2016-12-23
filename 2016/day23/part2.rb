# susan evans
# last edited 12/23/2016
# advent of code 2016, day 23, part 2

class Part2
	CONST_TOGGLE_MAP = {inc: :dec, dec: :inc, tgl: :inc, jnz: :cpy, cpy: :jnz}
	CONST_MULT = [:cpy, :inc, :dec, :jnz, :dec, :jnz]
	CONST_MAX_INPUTS = 3
	CONST_A_START_VALUE = 12

	def initialize(file_name)
		@instructions = []
		@registers = {a: CONST_A_START_VALUE, b: 0, c: 0, d: 0}
		process_file(file_name)	
		add_mul
		process_instructions
		output
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

	def process_instructions
		pos = 0
		while pos < @instructions.length
			instr = @instructions[pos]
			if instr[:type] == :mul
				@registers[instr[3]] += @registers[instr[1]] * @registers[instr[2]]
			elsif instr[:type] == :cpy && !is_number?(instr[2])
				@registers[instr[2]] = is_number?(instr[1])? instr[1] : @registers[instr[1]]
			elsif instr[:type] == :inc
				@registers[instr[1]] += 1
			elsif instr[:type] == :dec
				@registers[instr[1]] -= 1
			elsif instr[:type] == :tgl && (tgl = pos + @registers[instr[1]]) < @instructions.length
				@instructions[tgl][:type] = CONST_TOGGLE_MAP[@instructions[tgl][:type]]
			elsif instr[:type] == :jnz && @registers[instr[1]] != 0 
				inc = is_number?(instr[2]) ? instr[2] : @registers[instr[2]]
				pos += inc - 1 if (pos + inc - 1) < @instructions.length
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

	def output
		puts "#{@registers[:a]} is left in register a"
	end
end

Part2.new("input.txt")
