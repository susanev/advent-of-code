class Part1
	CONST_LENGTH = 8

	def initialize(file_name)
		@count = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				nets = line.scan(/(?<=\[)[a-z]+(?=\])/)
				strs = line.scan(/[a-z]+(?=\[)/)
				strs.push(line.scan(/[a-z]+$/)[0])
				count(strs, nets)
			end 
		end
	end

	def count(strs, nets)
		if strs.map { |str| abba(str)}.flatten.count(true) >= 1 && 
				nets.map { |str| abba(str)}.flatten.count(true) == 0
			@count += 1
		end
	end

	def abba(str)
		index = 0
		(str.length - 3).times do
			if (str[index] == str[index+3] && str[index+1] == str[index+2]) && 
						str[index] != str[index+2]
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