# susan evans
# last edited 12/03/2017
# advent of code 2015, day 10, part 1

class Part1
	def initialize(file_name)
		@sum = 0
		process_file(file_name)
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				num = line.to_i
				40.times do
					num = process(num)
				end
				@sum += num.to_s.length
			end
		end
	end

	def process(num)
		new_num = 0
		place = 1
		while num > 0
			count = 1
			digit = num % 10
			num = num / 10
			while num % 10 == digit
				count += 1
				num = num / 10
			end
			new_num = count * (place * 10) + digit * (place * 1) + new_num
			place *= 100
		end
		return new_num
	end

	def output
		puts "sum: #{@sum}"
	end
end

Part1.new("input.txt")