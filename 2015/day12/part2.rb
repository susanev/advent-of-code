# susan evans
# last edited 12/10/2017
# advent of code 2015, day 12, part 2

class Part2
	def initialize(file_name)
		@sum = 0
		process_file(file_name)
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.scan(/(?=\{((?:[^{}]++|\{\g<1>\})++)\})/)
				line.each do |okay|
					puts okay
					puts "\n"
				end
				# line.split(/[\,,\:, \[, \], \{, \}, \"]/).
				# 	reject { |val| !is_integer?(val) }.
				# 	each { |num| @sum += num.to_i}
			end
		end
	end

	def is_integer?(val)
		return val.to_i.to_s == val
	end

	def output
		puts "#{@sum}"
	end

end

Part2.new("input.txt")