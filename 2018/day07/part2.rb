# susan evans
# last edited 12/06/2018
# advent of code 2018, day 7, part 2

require 'set'

class Part2
	def initialize(file_name)
		@total_sec = 0
		@pos = [].to_set
		@instr = {}
		processFile(file_name)
		@done = findStart
		@final_order = []
		@dont_add = []
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
		workers = [0, 0, 0, 0, 0]
		worker_hold = [nil, nil, nil, nil, nil]
		worker_keys = [[], [], [], [], []]
		while !@done.empty? || workers.reduce(&:+) > 0
			@total_sec += 1
			for i in 0...workers.length
				if workers[i] == 0 && !@done.empty?
					@done.sort!
					workers[i] = (@done[0].to_s.ord - 64) + 60
					worker_hold[i] = @done[0]
					worker_keys[i] = find_keys_to_delete(@done[0])
					@done.delete_at(0)
				end
				if workers[i] > 0
					workers[i] -= 1
				end
			end

			for i in 0...workers.length
				if workers[i] == 0
					@final_order.push(worker_hold[i])
					worker_hold[i] = nil
					worker_keys[i].each do |key|
						@instr.delete(key)
						if !@dont_add.include?(key)
							@done.push(key)
						end
						@dont_add.push(key)
					end
				end
			end
		end
	end

	def find_keys_to_delete(val)
		keys_to_delete = []
		@instr.each do |k,v|
			if v.include?(val)
				if v.length == 1
					keys_to_delete.push(k)
				else
					@instr[k].delete(val)
				end
			end
		end
		return keys_to_delete
	end

	def output
		puts "#{@total_sec}"
	end
end

Part2.new("input.txt")