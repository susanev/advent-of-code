# susan evans
# last edited 12/07/2018
# advent of code 2018, day 7, part 2

require 'set'

class Worker
	attr_accessor :work_to_do, :work_to_trash,
				:work_to_add
	def initialize
		@work_to_do = 0
		@work_to_trash = nil
		@work_to_add = []
	end
end

class Workers(amt)
	attr_accessor :time_worked, :time_to_work,
			:workers
	def initalize
		@workers = Array.new(amt, Worker.new)
		@time_worked = 0
		@time_to_work = 0
	end

	def work
		@workers.each do |worker|
			if worker.work_to_do == 0 && !@done.empty?
				@done.sort!
				worker.work_to_do = (@done[0].to_s.ord - 64) + 60
				worker.work_to_trash = @done[0]
				worker.work_to_add = find_keys_to_delete(@done[0])
				@done.delete_at(0)
			end
			if worker.work_to_do > 0
				worker.work_to_do -= 1
			end
		end

		@workers.each do |worker|
			if worker.work_to_do == 0
				@final_order.push(worker.work_to_trash)
				worker.work_to_trash = nil
				worker.work_to_add.each do |key|
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


class Part2
	def initialize(file_name)
		@workers = Workers.new(5)
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
		while !@done.empty? || @workers.time_to_work > 0
			@worker.time_worked += 1
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