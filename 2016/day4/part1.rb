class Part1
	def initialize(file_name)
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				sides = line.chomp.split(" ").map(& :to_i)
			end
		end
	end

	def process

	end

	def output
		puts "output"
	end
end

Part1.new("input.txt")