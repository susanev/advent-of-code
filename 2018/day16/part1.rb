# susan evans
# last edited 12/16/2018
# advent of code 2018, day 16, part 1

class Part1
	def initialize(file_name)
		@methods = [:addr, :addi, :mulr, :muli,
					:banr, :bani, :borr, :bori,
					:setr, :seti, :gtir, :gtri,
					:gtrr, :eqir, :eqri, :eqrr]
		@total_count = 0

		process_file(file_name)
		output
	end

	def process_file(file_name)
		input = File.open(file_name, "r").readlines
		pos = 0
		while !input[pos].nil?
			before = input[pos].scan(/\d+/).map(&:to_i)
			inst, a, b, c = input[pos + 1].scan(/\d+/).map(&:to_i)
			after = input[pos + 2].scan(/\d+/).map(&:to_i)

			count = 0
			@methods.each do |meth|
				count += send(meth, a, b, c, before.clone, after)
			end

			if count >= 3
				@total_count += 1
			end
			pos += 4
		end
	end

	def addr(a, b, c, regs, after)
		regs[c] = regs[a] + regs[b]
		return regs == after ? 1 : 0
	end

	def addi(a, b, c, regs, after)
		regs[c] = regs[a] + b
		return regs == after ? 1 : 0
	end

	def mulr(a, b, c, regs, after)
		regs[c] = regs[a] * regs[b]
		return regs == after ? 1 : 0
	end

	def muli(a, b, c, regs, after)
		regs[c] = regs[a] * b
		return regs == after ? 1 : 0
	end

	def banr(a, b, c, regs, after)
		regs[c] = regs[a] & regs[b]
		return regs == after ? 1 : 0
	end

	def bani(a, b, c, regs, after)
		regs[c] = regs[a] & b
		return regs == after ? 1 : 0
	end

	def borr(a, b, c, regs, after)
		regs[c] = regs[a] | regs[b]
		return regs == after ? 1 : 0
	end

	def bori(a, b, c, regs, after)
		regs[c] = regs[a] | b
		return regs == after ? 1 : 0
	end

	def setr(a, b, c, regs, after)
		regs[c] = regs[a]
		return regs == after ? 1 : 0
	end

	def seti(a, b, c, regs, after)
		regs[c] = a
		return regs == after ? 1 : 0
	end

	def gtir(a, b, c, regs, after)
		regs[c] = a > regs[b] ? 1 : 0
		return regs == after ? 1 : 0
	end

	def gtri(a, b, c, regs, after)
		regs[c] = regs[a] > b ? 1 : 0
		return regs == after ? 1 : 0
	end

	def gtrr(a, b, c, regs, after)
		regs[c] = (regs[a] > regs[b] ? 1 : 0)
		return regs == after ? 1 : 0
	end

	def eqir(a, b, c, regs, after)
		regs[c] = (a == regs[b]) ? 1 : 0
		return regs == after ? 1 : 0
	end

	def eqri(a, b, c, regs, after)
		regs[c] = (regs[a] == b) ? 1 : 0
		return regs == after ? 1 : 0
	end

	def eqrr(a, b, c, regs, after)
		regs[c] = (regs[a] == regs[b]) ? 1 : 0
		return regs == after ? 1 : 0
	end

	def output
		puts "#{@total_count}"
	end
end

Part1.new("input.txt")

