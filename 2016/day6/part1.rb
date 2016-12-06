class Part1
	CONST_LENGTH = 8

	def initialize(file_name)
		@answer = ""
		@str = "abcdefghijklmnopqrstuvwxyz".split("")
		@common = []
		CONST_LENGTH.times do |i|
			@common[i] = {}
			@str.each do |s|
				@common[i][s] = 0
			end
		end
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp
				line.split("").each_with_index do |s, i|
					@common[i][s] += 1
				end
			end 
		end
	end

	def output
		@common.each do |h|
			@answer += h.max_by{ |k,v| v }[0]
		end
		puts "the original message is #{@answer}"
	end
end

Part1.new("input.txt")