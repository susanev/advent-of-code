# susan evans
# last edited 12/16/2017
# advent of code 2017, day 16, part 1


# According to the manual, the device has four registers (numbered 0 through 3)
# that can be manipulated by instructions containing one of 16 opcodes.
# The registers start with the value 0.

# Every instruction consists of four values: an opcode, two inputs (named A and B),
# and an output (named C), in that order. The opcode specifies the behavior of the
# instruction and how the inputs are interpreted. The output, C, is always treated as a register.

class Part1
	def initialize(file_name)
		@methods = [:addr, :addi, :mulr, :muli,
					:banr, :bani, :borr, :bori,
					:setr, :seti, :gtir, :gtri,
					:gtrr, :eqir, :eqri, :eqrr]
		@opscodes = {}
		@registers = [0, 0, 0, 0]
		process_file(file_name)
	end

	def process_file(file_name)
		input = File.open(file_name, "r").readlines
		pos = 0
		while !input[pos].nil? && input[pos].include?("Before")
			codes = []

			before = input[pos].scan(/\d+/).map(&:to_i)
			inst, a, b, c = input[pos + 1].scan(/\d+/).map(&:to_i)
			after = input[pos + 2].scan(/\d+/).map(&:to_i)

			@methods.each do |meth|
				if send(meth, a, b, c, before.clone, after)
					codes.push(meth)
				end
			end

			if @opscodes[inst] == nil
				@opscodes[inst] = codes
			else
				@opscodes[inst] = @opscodes[inst] & codes
			end
			pos += 4
		end

		until @opscodes.values.map(&:length).reduce(:+) == 16
			only_kids = []
			@opscodes.each do |k,v|
				if v.length == 1
					only_kids.push(v[0])
				end
			end
			@opscodes.each do |k,v|
				if v.length > 1
					only_kids.each do |kid|
						v.delete(kid)
					end
				end
			end
		end

		# solve separately, need to come back and clean this up
		# pos += 2
		# while pos < input.length

		# 	inst, a, b, c = input[pos].scan(/\d+/).map(&:to_i)
		# 	send(@opscodes[inst], a, b, c
		# 	send(meth, a, b, c, before.clone, after)
		# 	pos += 1
		# end

		#{10=>[:addr], 6=>[:addi], 14=>[:banr], 1=>[:seti], 
		# 12=>[:bori], 13=>[:eqri], 15=>[:setr], 8=>[:eqir],
		# 0=>[:muli], 7=>[:gtir], 2=>[:bani], 9=>[:mulr],
		# 3=>[:gtri], 11=>[:borr], 4=>[:gtrr], 5=>[:eqrr]}

	end

	def addr(a, b, c, regs, after)
		regs[c] = regs[a] + regs[b]
		return regs == after
	end

	def addi(a, b, c, regs, after)
		regs[c] = regs[a] + b
		return regs == after
	end

	def mulr(a, b, c, regs, after)
		regs[c] = regs[a] * regs[b]
		return regs == after
	end

	def muli(a, b, c, regs, after)
		regs[c] = regs[a] * b
		return regs == after
	end

	def banr(a, b, c, regs, after)
		regs[c] = regs[a] & regs[b]
		return regs == after
	end

	def bani(a, b, c, regs, after)
		regs[c] = regs[a] & b
		return regs == after
	end

	def borr(a, b, c, regs, after)
		regs[c] = regs[a] | regs[b]
		return regs == after
	end

	def bori(a, b, c, regs, after)
		regs[c] = regs[a] | b
		return regs == after
	end

	def setr(a, b, c, regs, after)
		regs[c] = regs[a]
		return regs == after
	end

	def seti(a, b, c, regs, after)
		regs[c] = a
		return regs == after
	end

	def gtir(a, b, c, regs, after)
		regs[c] = a > regs[b] ? 1 : 0
		return regs == after
	end

	def gtri(a, b, c, regs, after)
		regs[c] = regs[a] > b ? 1 : 0
		return regs == after
	end

	def gtrr(a, b, c, regs, after)
		regs[c] = (regs[a] > regs[b] ? 1 : 0)
		return regs == after
	end

	def eqir(a, b, c, regs, after)
		regs[c] = (a == regs[b]) ? 1 : 0
		return regs == after
	end

	def eqri(a, b, c, regs, after)
		regs[c] = (regs[a] == b) ? 1 : 0
		return regs == after
	end

	def eqrr(a, b, c, regs, after)
		regs[c] = (regs[a] == regs[b]) ? 1 : 0
		return regs == after
	end

	def output
		puts "#{@registers[0]}"
	end
end

Part1.new("input.txt")

