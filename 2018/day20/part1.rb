# susan evans
# last edited 12/20/2017
# advent of code 2017, day 20, part 1

class Part1
	def initialize(file_name)
		@closest = 0
		@particles = []
		processFile(file_name)
		# this is hack, im not sure how to figure out when to stop
		350.times do
			tick
		end
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				data = line.split(", ")
				data.each_with_index do |d, d_index|
					data[d_index] = d.scan(/\-*\d+/).map(&:to_i)
				end
				@particles.push({p: data[0], v: data[1], a: data[2]})
			end
		end
	end

	def tick
		find_closest
		@particles.each_with_index do |particle|
			3.times do |n|
				particle[:v][n] += particle[:a][n]
				particle[:p][n] += particle[:v][n]
			end
		end
	end

	def find_closest
		closest_sum = position_sum(@particles[@closest][:p])
		@particles.each_with_index do |particle, p_index|
			curr_sum = position_sum(particle[:p])
			if  curr_sum < closest_sum
				@closest = p_index
				closest_sum = curr_sum
			end
		end
	end

	def position_sum(positions)
		return positions.inject(0){ |sum, val| sum + val.abs }
	end

	def output
		puts "#{@closest}"
	end
end

Part1.new("input.txt")
