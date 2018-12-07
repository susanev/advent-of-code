# susan evans
# last edited 12/24/2017
# advent of code 2017, day 25, part 1

class Part1
	def initialize(file_name)
		@state = :A
		@pos = 0
		@tape = {}
		@instructions = {A: {zero_dir: 1, zero_state: :B, one_val: 0, one_dir: -1, one_state: :E},
						 B: {zero_dir: -1, zero_state: :C, one_val: 0, one_dir: 1, one_state: :A},
						 C: {zero_dir: -1, zero_state: :D, one_val: 0, one_dir: 1, one_state: :C},
						 D: {zero_dir: -1, zero_state: :E, one_val: 0, one_dir: -1, one_state: :F},
						 E: {zero_dir: -1, zero_state: :A, one_val: 1, one_dir: -1, one_state: :C},
						 F: {zero_dir: -1, zero_state: :E, one_val: 1, one_dir: 1, one_state: :A}}
		12386363.times do
			process
		end
		output
	end

	def process
		curr = @tape[@pos]
		instruction = @instructions[@state]
		if curr.nil? || curr == 0
			@tape[@pos] = 1
			@pos += instruction[:zero_dir]
			@state = instruction[:zero_state]
		else
			@tape[@pos] = instruction[:one_val]
			@pos += instruction[:one_dir]
			@state = instruction[:one_state]
		end
	end

	def output
		puts "#{@tape.values.count(1)}"
	end
end

Part1.new("input.txt")
