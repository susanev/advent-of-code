# a terrible brute force solution
# will come back to this later
# need to relearn all the things
class Part2
	def initialize(file_name)
		@cmds = {}
		@all_signals = false
		process_file(file_name)
		@cmds[:b] = [3176]

		until @all_signals do
			process_direct_signals
			process_cmds
		end

		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.split(" ")
				if line.length == 3
					@cmds[convert(line.last)] = convert_line(line[0, line.length - 2])
				else
					@cmds[convert(line.last)] = convert_line(line[0, line.length - 2])
				end
			end
		end
	end

	def is_number?(value)
		true if Integer(value) rescue false
	end

	def convert(str)
		Integer(str) if Integer(str) rescue str.to_sym
	end

	def convert_line(line)
		line.each_with_index do |element, index|
			line[index] = convert(element)
		end
	end

	def process_direct_signals
		@cmds.each do |basek,basev|
			if basev.length == 1 && is_number?(basev[0])
				@cmds.each do |k,v|
					if v.include? basek
						@cmds[k][v.index(basek)] = basev[0]
					end
				end
			end
		end
	end

	def process_cmds
		count = 0
		@cmds.each do |k,v|
			if v.include?(:NOT) && is_number?(v[1])
				@cmds[k] = [65525 - v[1]]
			elsif v.include?(:AND) && is_number?(v[0]) && is_number?(v[2])
				@cmds[k] = [v[0] & v[2]]
			elsif v.include?(:OR) && is_number?(v[0]) && is_number?(v[2])
				@cmds[k] = [v[0] | v[2]]
			elsif v.include?(:LSHIFT) && is_number?(v[0])
				@cmds[k] = [v[0] << v[2]]
			elsif v.include?(:RSHIFT) && is_number?(v[0])
				@cmds[k] = [v[0] >> v[2]]
			else
				count += 1
			end
		end

		if count == @cmds.length
			@all_signals = true
		end
	end

	def output
		puts "#{@cmds[:a]}"
	end
end

Part2.new("input.txt")