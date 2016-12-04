class Part1
	def initialize(file_name)
		@letters = "abcdefghijklmnopqrstuvwxyz".split("")
		@sum = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				frequency = setFrequency(line[/[a-z]*(-[a-z]+)*/])		
				if createCode(frequency) == line[/(?<=\[)[a-z]*/]
					@sum += line[/\d+/].to_i
				end
			end
		end
	end

	def setFrequency(room_name)
		frequency = {}
		# needed to ensure alphabetical order of code
		# forces all letters into hash (in order)
		@letters.each do |letter|
			frequency[letter.to_sym] = 0
		end

		room_name.split("").each do |letter|
			if letter != "-"
				frequency[letter.to_sym] += 1
			end
		end
		return frequency
	end

	def createCode(frequency)
		code = ""
		5.times do
			k,v = frequency.max_by{ |k,v| v }
			frequency[k] = 0
			code += k.to_s
		end
		return code
	end

	def output
		puts "the sum of the sector IDs of real rooms is #{@sum}"
	end
end

Part1.new("input.txt")