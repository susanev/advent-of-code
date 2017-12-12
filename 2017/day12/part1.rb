# susan evans
# last edited 12/11/2017
# advent of code 2017, day 12, part 1

class Part1
	def initialize(file_name)
		@programs = {}
		@connections = [0]
		processFile(file_name)
		process(0)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				prog = line[/\d+\s/].to_i
				arrow_index = line.index("<->")
				to = line[arrow_index + 4..line.length].split(",").map(&:to_i)
				@programs[prog] = to
			end
		end
	end

	def process(n)
		prev = nil
		while prev != @connections.sort.to_s
			prev = @connections.clone.sort.to_s
			@programs.clone.each do |prog, to|
				if prog == n
					to.each do |val|
						@connections.push(val)
						@programs.delete(prog)
					end
				elsif to.include?(n)
					@connections.push(prog)
					@programs.delete(prog)
				else
					to.each do |val|
						if @connections.include?(val)
							@connections.push(prog)
							@programs.delete(prog)
						end
					end
				end
			end
			@connections.uniq!
		end
	end

	def output
		puts "#{@connections.length}"
	end
end

Part1.new("input.txt")
