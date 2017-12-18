# susan evans
# last edited 12/17/2017
# advent of code 2017, day 18, part 1

class Part1
	def initialize(file_name)
		@last_sound = nil
		@registers = {}
		@instructions = []
		@pos = 0
		@rcv_found = false
		processFile(file_name)
		process
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

	def process
		while !@rcv_found
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
			elsif line.include?("mul")
				mul(first, second)
			elsif line.include?("mod")
				mod(first, second)
			elsif line.include?("rcv")
				rcv(first)
			elsif line.include?("jgz")
				jgz(first, second)
			end
			@pos += 1
		end
	end

	def snd(x)
		@last_sound = @registers[x]
	end

	def set(x, y)
		@registers[x] = y
	end

	def add(x, y)
		if @registers[x].nil?
			@registers[x] = y
		else
			@registers[x] += y
		end
	end

	def mul(x, y)
		if @registers[x].nil?
			@registers[x] = 0
		else
			@registers[x] *= y
		end
	end

	def mod(x, y)
		if @registers[x].nil?
			@registes[x] = 0
		else
			@registers[x] %= y
		end
	end

	def rcv(x)
		if @registers[x] != 0
			@rcv_found = true
		end
	end

	def jgz(x, y)
		if @registers[x] > 0
			@pos += y
			@pos -= 1
		end
	end

	def output
		puts "#{@last_sound}"
	end
end

Part1.new("input.txt")


