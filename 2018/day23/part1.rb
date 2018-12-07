# susan evans
# last edited 12/23/2017
# advent of code 2017, day 23, part 1

class Part1
	def initialize(file_name)
		@count = 0
		@registers = {}
		registers = "abcdefgh".split("")
		registers.each do |val|
			@registers[val] = 0
		end
		@instructions = []
		@pos = 0
		processFile(file_name)
		process
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@instructions.push(line.chomp)
			end
		end
	end

	def process
		while @pos < @instructions.length
			line = @instructions[@pos]
			numbers = line[4...line.length].split(" ")
			first = numbers[0]
			if numbers.length > 1
				second = numbers[1]
				if second.to_i.to_s == second
					second = second.to_i
				else
					second = @registers[second]
				end
			end
			if line.include?("snd")
				snd(first)
			elsif line.include?("set")
				set(first, second)
			elsif line.include?("add")
				add(first, second)
			elsif line.include?("sub")
				add(first, -second)
			elsif line.include?("mul")
				mul(first, second)
				@count += 1
			elsif line.include?("mod")
				mod(first, second)
			elsif line.include?("rcv")
				rcv(first)
			elsif line.include?("jnz")
				jnz(first, second)
			end
			@pos += 1
		end
	end

	def set(x, y)
		@registers[x] = y
	end

	def add(x, y)
		@registers[x] += y
	end

	def mul(x, y)
		@registers[x] *= y
	end

	def mod(x, y)
		@registers[x] %= y
	end

	def jnz(x, y)
		if x.to_s.to_i == x
			val = x
		else
			val = @registers[x]
		end
		if val != 0
			@pos += y
			@pos -= 1
		end
	end

	def output
		puts "#{@count}"
	end
end

Part1.new("input.txt")

