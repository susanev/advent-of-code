# susan evans
# last edited 12/09/2016
# advent of code 2016, day 10, part 1
# processes a file of instructions, to discover
# the bot that compares the CONST_LOW and 
# CONST_HIGH values

class Part1
	CONST_LOW = 17;
	CONST_HIGH = 61;

	def initialize(file_name)
		@instructions = {}
		@bots = {}
		210.times do |bot|
			@bots[bot] = []
		end
		@bot = 0
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
	# repeats until the values are found
	def process_instructions
		while @bot == 0
			@bots.each do |bot, bot_values|
				if bot_values.length > 1
					if bot_values.min == CONST_LOW && bot_values.max == CONST_HIGH
						@bot = bot
					end

					if !@instructions[bot][:low][:bot].nil?
						@bots[@instructions[bot][:low][:bot]].push(bot_values.min)
					end
					if !@instructions[bot][:high][:bot].nil?
						@bots[@instructions[bot][:high][:bot]].push(bot_values.max)
					end
					# clears the bots values and the processed instruction
					@bots[bot] = []
					@instructions.delete(bot)
				end
			end
		end
	end

	def output
		puts "the number of the bot is #{@bot}"
	end
end

Part1.new("input.txt")