# susan evans
# last edited 12/22/2016
# advent of code 2016, day 23, part 2

# works, super sloppy .. will come back
# edited the file, to include mul

class Part2
	def initialize(file_name)
		@instructions = []
		@registers = {a: 12, b: 0, c: 0, d: 0}
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
			if !line[2].nil?
				instr[2] = convert(line[2])
			end
			if !line[3].nil?
				instr[3] = convert(line[3])
			end
			@instructions.push(instr)
	end

	def process_instructions
		pos = 0
		while pos < @instructions.length
			instr = @instructions[pos]
			if instr[:type] == :mul
				@registers[instr[1]] += (@registers[instr[2]] * @registers[instr[3]])
			elsif instr[:type] == :cpy_val
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
					if @instructions[toggle][:type] == :inc 
						@instructions[toggle] = {:type => :dec, 1 => @instructions[toggle][1]}
					elsif @instructions[toggle][:type] == :dec || @instructions[toggle][:type] == :tgl
						@instructions[toggle] = {:type => :inc, 1 => @instructions[toggle][1]}
					elsif @instructions[toggle][:type] == :jnz
						@instructions[toggle] = {:type => :cpy_ref, 1 => @instructions[toggle][1], 2 => @instructions[toggle][2]}
					elsif @instructions[toggle][:type] == :cpy_val || @instructions[toggle][:type] == :cpy_ref
						@instructions[toggle] = {:type => :jnz, 1 => @instructions[toggle][1], 2 => @instructions[toggle][2]}
					end
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

Part2.new("input2.txt")