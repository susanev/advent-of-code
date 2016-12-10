# susan evans
# last edited 12/09/2016
# advent of code 2016, day 10, part 2
# determines the product of the output indexes
# stored in CONST_PRODUCT

class Part2
	CONST_PRODUCT = [0, 1, 2]

	def initialize(file_name)
		@instructions = {}
		@output = []
		@bots = {}
		210.times do |bot|
			@bots[bot] = []
		end

		process_file(file_name)
		process_instructions
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				update_hashes(line.split(" "))
			end
		end
	end

	# builds the hash of @bots and their initial values
	# and the hash of instructions
	def update_hashes(line)
		if line.include? "value"
			@bots[line[5].to_i].push(line[1].to_i)
		else
			low_sym = line[5] == "output" ? :output : :bot
			high_sym = line[10] == "output" ? :output : :bot
			@instructions[line[1].to_i] = {:low => {low_sym => line[6].to_i}, :high => {high_sym =>line[11].to_i}}
		end
	end

	# processes the instructions, anytime a @bot holds two values
	# searches for the instructions for that bot
	# repeats until no more instructions are left
	def process_instructions
		until @instructions.empty?
			@bots.each do |bot, bot_values|
				if bot_values.length > 1
					if !@instructions[bot][:low][:bot].nil?
						@bots[@instructions[bot][:low][:bot]].push(bot_values.min)
					else
						@output[@instructions[bot][:low][:output]] = bot_values.min
					end
					if !@instructions[bot][:high][:bot].nil?
						@bots[@instructions[bot][:high][:bot]].push(bot_values.max)
					else
						@output[@instructions[bot][:high][:output]] = bot_values.max
					end
					# clears the bots values and the processed instruction
					@bots[bot] = []
					@instructions.delete(bot)
				end
			end
		end
	end

	def output
		puts "the product is #{@output[CONST_PRODUCT[0]]*@output[CONST_PRODUCT[1]]*@output[CONST_PRODUCT[2]]}"
	end
end

Part2.new("input.txt")