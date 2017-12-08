# susan evans
# last edited 12/08/2017
# advent of code 2017, day 7, part 2

# its a mess!!

class Part2
	def initialize(file_name)
		@orig = {}
		@end_values = {}
		@programs = []
		processFile(file_name)
		puts reduce
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line.chomp!
				program_name = line[/[a-z]+/]
				program_val = line[/\d+/].to_i
				program_children = line[line[/[a-z]+[\s(\d*)]/].length + 
									line[/\d+/].length + 
									6...line.length]
				if program_children.nil?
					@end_values[program_name] = program_val
				else
					program_children = program_children.split(", ")
					children = []
					program_children.each do |child|
						children.push({item_name: child, item_val: nil})
					end
					@programs.push({prog_name: program_name, val: program_val, children: children})
				end
				@orig[program_name] = program_val
			end
		end
	end

	def reduce
		while @programs.length > 1
			@programs.each_with_index do |program, prog_index|
				program[:children].each_with_index do |child, child_index|
					if @end_values[child[:item_name]] != nil
						@programs[prog_index][:children][child_index][:item_val] = @end_values[child[:item_name]]
						puts "programs: #{@programs}"
						puts "---\n"
					end
				end
				child_values = all_integers(program[:children])
				if child_values.all? { |val| val.is_a? Integer }
					uniq_vals = child_values.uniq
					if uniq_vals.length > 1
						if child_values.count(uniq_vals[0]) == 1
							return uniq_vals[1] - uniq_vals[0]
						else
							return uniq_vals[0] - uniq_vals[1]
						end
					end
					sum = vals.inject(0, :+) + program[:val]
					@end_values[program[:prog_name]] = sum
					@programs.delete(program)
				end
			end
		end
	end

	def all_integers(children)
		children_vals = []
		children.each do |item, val|
			children.push(val)
		end
		return children_vals
	end

	def children_reduced?
		@programs.each do |program|
			if program[:children] != nil && !program[:children].flatten.all? { |val| val.is_a? Integer }
				return false
			end
		end
		return true
	end
end

Part2.new("input.txt")
