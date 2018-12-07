# susan evans
# last edited 12/07/2017
# advent of code 2017, day 8, part 1

class Part1
	def initialize(file_name)
		@regex_num = /\-*\d+/
		@registers = {}
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				eval(line)
			end
		end
	end

	def eval(line)
		reg = line[/[a-z]+/]
		set_reg(reg)
		dir = line.include?("inc") ? "inc" : "dec"
		val = line[@regex_num].to_i
		condition = line[line.index(" if ") + 4...line.length]
		cond_reg = condition[/[a-z]+/]
		cond_val = condition[@regex_num].to_i
		set_reg(cond_reg)
		if condition.include?("!=") && @registers[cond_reg] != cond_val ||
				condition.include?("==") && @registers[cond_reg] == cond_val ||
				condition.include?("<=") && @registers[cond_reg] <= cond_val ||
				condition.include?(">=") && @registers[cond_reg] >= cond_val ||
				condition.include?("<") && @registers[cond_reg] < cond_val ||
				condition.include?(">") && @registers[cond_reg] > cond_val
			dir == "inc" ? @registers[reg] += val : @registers[reg] -= val
		end
	end

	def set_reg(reg)
		if @registers[reg].nil?
			@registers[reg] = 0
		end
	end

	def output
		puts "#{@registers.values.max}"
	end
end

Part1.new("input.txt")
