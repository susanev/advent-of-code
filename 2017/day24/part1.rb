# susan evans
# last edited 12/24/2017
# advent of code 2017, day 24, part 1

class Part1
	def initialize(file_name)
		@pins = {}
		@paths = []
		processFile(file_name)
		start
		@max = 0
		prev = nil
		while prev != @max
			prev = find_max
			iterate
			@max = find_max
		end
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				sizes = line.scan(/\d+/).map(&:to_i)
				if @pins[sizes[0]].nil?
					@pins[sizes[0]] = [sizes[1]]
				else
					@pins[sizes[0]].push(sizes[1])
				end
				if @pins[sizes[1]].nil?
					@pins[sizes[1]] = [sizes[0]]
				else
					@pins[sizes[1]].push(sizes[0])
				end
			end
		end
	end

	def start
		@pins[0].each do |port|
			@paths.push([[0, port]])
		end
	end

	def iterate
		@paths.each do |path|
			pins = @pins[path.last.last]
			i = 1
			while i < pins.length
				if !path.include?([pins[i], path.last.last]) &&
						!path.include?([path.last.last, pins[i]])
					@paths.push(path.clone.push([path.last.last, pins[i]]))
				end
				i += 1
			end
			if !path.include?([pins[0], path.last.last]) &&
					!path.include?([path.last.last, pins[0]])
				path.push([path.last.last, pins[0]])
			end
		end
	end

	def find_max
		max = 0
		@paths.each do |path|
			max = [max, path.flatten.inject(0){ |sum, x| sum + x }].max
		end
		puts max
		return max
	end

	def output
		puts "#{@max}"
	end
end

Part1.new("input.txt")
