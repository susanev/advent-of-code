# susan evans
# last edited 12/18/2017
# advent of code 2017, day 18, part 2

class Part2
	def initialize(file_name)
		@registers = [{p: 0}, {p: 1}]
		@instructions = []
		@messages = [[], []]
		@pos = [0, 0]
		@program = 0
		@waiting = [false, false]
		@count = 0
		processFile(file_name)
		compelte_instructions
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@instructions.push(line)
			end
		end
	end

	def compelte_instructions
		while !@waiting.all? &&
					(@pos[0] != @instructions.length || @pos[1] != @instructions.length)
			line = @instructions[@pos[@program]]
			numbers = line[4...line.length].split(" ")
			first = numbers[0]
			if numbers.length > 1
				second = eval(numbers[1])
			end
			if line.include?("snd")
				snd(first)
			elsif line.include?("rcv")
				rcv(first.to_sym)
			elsif line.include?("set")
				set(first.to_sym, second)
			elsif line.include?("add")
				add(first.to_sym, second)
			elsif line.include?("mul")
				mul(first.to_sym, second)
			elsif line.include?("mod")
				mod(first.to_sym, second)
			elsif line.include?("jgz")
				jgz(first, second)
			end
			@program = @program == 0 ? 1 : 0
		end
	end

	def eval(val)
		if val.to_i.to_s == val
			return val.to_i
		else
			return @registers[@program][val.to_sym]
		end
	end

	def snd(x)
		val = eval(x)
		if @program == 0
			@messages[1].unshift(val)
		else
			@count += 1
			@messages[0].unshift(val)
		end
		@pos[@program] += 1
	end

	def rcv(x)
		if @messages[@program].empty?
			@waiting[@program] = true
		else
			@registers[@program][x] = @messages[@program].pop
			@waiting[@program] = false
			@pos[@program] += 1
		end
	end

	def set(x, y)
		@registers[@program][x] = y
		@pos[@program] += 1
	end

	def add(x, y)
		if @registers[@program].nil?
			@registers[@program][x] = y
		else
			@registers[@program][x] += y
		end
		@pos[@program] += 1
	end

	def mul(x, y)
		if @registers[@program].nil?
			@registers[@program][x] = 0
		else
			@registers[@program][x] *= y
		end
		@pos[@program] += 1
	end

	def mod(x, y)
		if @registers[@program].nil?
			@registers[@program][x] = 0
		else
			@registers[@program][x] %= y
		end
		@pos[@program] += 1
	end

	def jgz(x, y)
		val = eval(x)
		if val > 0
			@pos[@program] += y
		else
			@pos[@program] += 1
		end
	end

	def output
		puts "#{@count}"
	end
end

Part2.new("input.txt")


