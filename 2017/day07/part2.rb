# susan evans
# last edited 12/09/2017
# advent of code 2017, day 7, part 2

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
		while @programs.length > 0
			@programs.each_with_index do |program, prog_index|
				replace_programs(program, prog_index)
				child_values = all_integers(program[:children])
				if child_values.index(nil).nil?
					uniq_vals = child_values.uniq
					if uniq_vals.length > 1
						return child_values.count(uniq_vals[0]) == 1 ?					
							return find_name(program[:children], uniq_vals[0]) +
									uniq_vals[1] - uniq_vals[0] :
							return find_name(program[:children], uniq_vals[1]) +
									uniq_vals[0] - uniq_vals[1]
						end
					end
					@end_values[program[:prog_name]] = child_values.inject(0, :+) +
							program[:val]
					@programs.delete(program)
				end
			end
		end
	end

	def replace_programs(program, prog_index)
		program[:children].each_with_index do |child, child_index|
			if @end_values[child[:item_name]] != nil
				@programs[prog_index][:children][child_index][:item_val] =
						@end_values[child[:item_name]]
			end
		end
	end

	def find_name(children, val)
		children.each do |child|
			if child[:item_val] == val
				return @orig[child[:item_name]]
			end
		end
	end

	def all_integers(children)
		children_vals = []
		children.each do |child|
			children_vals.push(child[:item_val])
		end
		return children_vals
	end
end

Part2.new("input.txt")
