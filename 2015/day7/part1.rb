# a terrible brute force solution
# will come back to this later
# need to relearn all the things
class Part1
	def initialize(file_name)
		@cmds = {}
		process_file(file_name)
		until @cmds[:a].length == 1 && is_number?(@cmds[:a][0]) do
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
		if is_number?(str)
			return Integer(str)
		else
			return str.to_sym
		end
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
			end
		end
	end

	def output
		puts "#{@cmds[:a]}"
	end
end

Part1.new("input.txt")