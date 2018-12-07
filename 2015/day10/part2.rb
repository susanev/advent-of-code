# susan evans
# last edited 12/03/2017
# advent of code 2015, day 10, part 1

class Part1
	def initialize(file_name)
		process_file(file_name)
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				len = 0
				num = line
				40.times do
					num = num.to_s
					if num.length >= 10
						num = num[0...num.length / 2]
						len += num.length / 2
					end
					num = process(num.to_i)
				end
				puts len + num.to_s.length
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
end

Part1.new("input.txt")


