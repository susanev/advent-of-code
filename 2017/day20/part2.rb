# susan evans
# last edited 12/20/2017
# advent of code 2017, day 20, part 2

class Part2
	def initialize(file_name)
		@closest = 0
		@particles = []
		processFile(file_name)
		remove_collisions
		# this is hack, im not sure how to figure out when to stop
		50.times do
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
		remove_collisions
		@particles.each_with_index do |particle|
			if particle[:p] != "collision"
				3.times do |n|
					particle[:v][n] += particle[:a][n]
					particle[:p][n] += particle[:v][n]
				end
			end
		end
	end

	def remove_collisions
		repeats = @particles.map{ |particle| particle[:p] }.group_by{ |val| val }.select { |k, v| v.size > 1}.map(&:first)
		repeats.each do |repeat|
			@particles.each_with_index do |particle, particle_index|
				if particle[:p] != "collision" && particle[:p] == repeat
					@particles[particle_index][:p] = "collision"
				end
			end
		end
	end

	def position_sum(positions)
		return positions.inject(0){ |sum, val| sum + val.abs }
	end

	def output
		puts "#{@particles.length - @particles.count { |particle| particle[:p] == "collision" }}"
	end
end

Part2.new("input.txt")
