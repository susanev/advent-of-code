class Part1
	def initialize(file_name)
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def output
		puts "output"
	end
end

Part1.new("input.txt")