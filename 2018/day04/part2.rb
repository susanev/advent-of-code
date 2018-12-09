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
		#count_1613 = []
		guard_asleep_values = []
		guard_number = nil
		asleep_count = 0
		asleep_marker = nil
		@lines.each do |line|
			minute = line[line.index(":") + 1...line.index("]")].to_i
			if line.include?("#")
				if guard_number != nil
					if @guards[guard_number]
						@guards[guard_number] += guard_asleep_values
					else
						@guards[guard_number] = guard_asleep_values
					end
				end
				guard_number = line.match(/(?<=#)\d+/).to_s.to_i
				guard_asleep_values = []
			elsif line.include?("asleep")
				asleep_marker = minute
			else
				for i in (asleep_marker...minute)
					guard_asleep_values.push(i)
				end
			end
		end
		if @guards[guard_number]
			@guards[guard_number] += guard_asleep_values
		else
			@guards[guard_number] = guard_asleep_values
		end

		@guards.each do |k,v|
			freq = v.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
			key = v.max_by { |v| freq[v] }
			@guards[k] = {key => freq[key]}
		end
		# puts count_1613.sort


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

# [1518-02-10 23:56] Guard #1487 begins shift
# [1518-02-11 00:14] falls asleep
# [1518-02-11 00:40] wakes up
# [1518-02-11 23:53] Guard #1493 begins shift
# [1518-02-12 00:04] falls asleep
# [1518-02-12 00:05] wakes up
# [1518-02-12 00:22] falls asleep
# [1518-02-12 00:43] wakes up