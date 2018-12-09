# susan evans
# last edited 12/04/2018
# advent of code 2018, day 4, part 1

#require 'time'

class Part1
	def initialize(file_name)
		@lines = []
		@guards = {}
		processFile(file_name)
		@lines.sort!
		process
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@lines.push(line.strip)
			end
		end
	end

#1613
#3
# Time.parse
	def process
		count_1613 = []
		guard_number = nil
		asleep_count = 0
		asleep_marker = nil
		@lines.each do |line|
			minute = line[line.index(":") + 1...line.index("]")].to_i
			if line.include?("#")
				if guard_number != nil
					if @guards[guard_number]
						@guards[guard_number] += asleep_count
					else
						@guards[guard_number] = asleep_count
					end
				end
				guard_number = line.match(/(?<=#)\d+/).to_s.to_i
				asleep_count = 0
			elsif line.include?("asleep")
				asleep_marker = minute
			else
				if guard_number == 131
					for i in (asleep_marker...minute)
						count_1613.push(i)
					end
				end
				asleep_count += minute - asleep_marker
			end
		end
		@guards[guard_number] = asleep_count
		puts count_1613.sort

		freq = count_1613.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		puts (count_1613.max_by { |v| freq[v] } * 131)
	end

	def output

		# @lines.each do |line|
		# 	puts line
		# end
		# puts "---"
		@guards.each do |k,v|
			puts "#{k}: #{v}"
		end
	end
end

Part1.new("input.txt")
