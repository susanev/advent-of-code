class Part2
	def initialize(file_name)
		@sum = 0
		@dup = nil
		@lines = []
		@answers = {}
		processFile(file_name)
		@dup = findDup
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lines.push(line.to_i)
			end
		end
	end

	def findDup
		while @dup == nil
			@lines.each do |num|
				@sum += num
				if @answers[@sum] == true
					return @sum
				else
					@answers[@sum] = true
				end
			end
		end
	end

	def output
		puts "#{@dup}"
	end
end

Part2.new("input.txt")
