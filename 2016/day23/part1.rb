# susan evans
# last edited 12/22/2016
# advent of code 2016, day 23, part 1

# works, super sloppy .. will come back

class Part1
	def initialize(file_name)
		@instructions = []
		@registers = {a: 7, b: 0, c: 0, d: 0}
		@toggle_map = {inc: :dec, dec: :inc, tgl: :inc, jnz: :cpy_ref, cpy_val: :jnz, cpy_ref: :jnz}
		process_file(file_name)	
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
			if line[0] == "cpy"
				if is_number? line[1]
					instr[:type] = :cpy_val
				else
					instr[:type] = :cpy_ref
				end
			else
				instr[:type] = line[0].to_sym
			end

			instr[1] = convert(line[1])
			instr[2] = convert(line[2]) if line[2]
			instr[3] = convert(line[3]) if line[3]
			@instructions.push(instr)
	end

	def process_instructions
		pos = 0
		while pos < @instructions.length
			instr = @instructions[pos]
			if instr[:type] == :cpy_val
				if !is_number?(instr[2])
					if is_number?(instr[1])
						@registers[instr[2]] = instr[1]
					else
						@registers[instr[2]] = @registers[instr[1]]
					end
				end
			elsif instr[:type] == :cpy_ref
				if !is_number?(instr[2])
					if is_number?(instr[1])
						@registers[instr[2].to_sym] = instr[1]
					else
						@registers[instr[2].to_sym] = @registers[instr[1]]
					end
				end
			elsif instr[:type] == :inc
				@registers[instr[1]] += 1
			elsif instr[:type] == :dec
				@registers[instr[1]] -= 1
			elsif instr[:type] == :tgl
				toggle = pos + @registers[instr[1]]
				if toggle < @instructions.length
					@instructions[toggle][:type] = @toggle_map[@instructions[toggle][:type]]
				end
			elsif @registers[instr[1]] != 0 #jnz
				if is_number?(instr[2])
					if (pos + instr[2] - 1) < @instructions.length 
						pos += instr[2] - 1
					end
				else
					if (pos + @registers[instr[2]] - 1) < @instructions.length 
						pos += @registers[instr[2]] - 1
					end
				end
			end
			pos += 1
		end
	end

	def convert(value)
		if is_number? value
			return value.to_i
		else
			return value.to_sym
		end
	end

	def is_number?(value)
		true if Integer(value) rescue false
	end

	def output
		puts "#{@registers[:a]} is left in register a"
	end
end

Part1.new("input.txt")
