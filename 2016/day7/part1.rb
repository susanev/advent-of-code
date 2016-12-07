class Part1
	CONST_LENGTH = 8

	def initialize(file_name)
		@count = 0
		@strs = []
		@nets = []
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.split("")
				str = ""
				line.each_with_index do |s, index|
					if s == "["
						@strs.push(str)
						str = ""
					elsif s == "]"
						@nets.push(str)
						str = ""
					else
						str += s
					end
				end
				if str.length != 0
					@strs.push(str)
				end
				 # puts @strs
				 # puts @nets
				n = @strs.map { |str| abba(str)}.flatten.count(true)
				x = @nets.map { |str| abba(str)}.flatten.count(true)
				if n>=1 && x==0
					@count += 1
				end
				@strs = []
				@nets = []
			end 
		end
	end

	def abba(str)
		index = 0
		(str.length - 3).times do
			if (str[index] == str[index+3] && str[index+1] == str[index+2]) && str[index] != str[index+2]
				return true
			end
			index += 1
		end
		return false
	end

	def output
		puts "the original message is #{@count}"
	end
end

Part1.new("input.txt")