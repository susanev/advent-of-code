class Part1
	CONST_LENGTH = 8

	def initialize(file_name)
		@count = 0
		@strs = []
		@nets = []
		@aba = []
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
				
				@strs.each do |str|
					aba(str)
				end
				puts @nets

				inc_count = false
				@nets.each do |str|
					@aba.each do |str2|
						if str.include? str2
							inc_count = true
						end
					end
				end

				if inc_count
					@count += 1
				end
				@strs = []
				@nets = []
				@aba = []
			end 
		end
	end

	def aba(str)
		index = 0
		(str.length - 2).times do
			if str[index] == str[index+2] && str[index] != str[index+1]
				@aba.push(str[index+1] + str[index] + str[index+1])
			end
			index += 1
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