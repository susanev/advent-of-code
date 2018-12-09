# susan evans
# last edited 12/07/2018
# advent of code 2018, day 7, part 1

require 'set'

class Part1
	def initialize(file_name)
		@pos = [].to_set
		@instr = {}
		processFile(file_name)
		puts @instr
		@done = findStart
		@final_order = []
		process
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				vals = line.scan(/[A-Z]+/).map(&:to_sym)
				vals.delete_at(0)
				@pos.add(vals[0])
				@pos.add(vals[1])

				if @instr[vals[1]]
					@instr[vals[1]].push(vals[0])
				else
					@instr[vals[1]] = [vals[0]]
				end
			end
		end
	end

	def findStart
		rem = @instr.keys.flatten.uniq
		rem.each do |key|
			@pos.delete(key)
		end
		return @pos.to_a
	end

	def process
		while !@done.empty?
			keys_to_delete = []
			@done.sort!
			@final_order.push(@done[0])
			@instr.each do |k,v|
				if v.include?(@done[0])
					if v.length == 1
						keys_to_delete.push(k)
					else
						@instr[k].delete(@done[0])
					end
				end
			end
			@done.delete_at(0)
			keys_to_delete.each do |key|
				@instr.delete(key)
				@done.push(key)
			end
		end
	end

	def output
		puts "#{@final_order.join}"
	end
end

Part1.new("input.txt")