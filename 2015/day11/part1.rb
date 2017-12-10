# susan evans
# last edited 12/10/2017
# advent of code 2015, day 11, part 1

class Part1
	def initialize(file_name)
		@passwords = []
		@letters = "abcdefghijklmnopqrstuvwxyz".split("")
		@password = nil
		process_file(file_name)
		find_next
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@password = line.chomp
				@passwords.push(@password.clone)
			end
		end
	end

	def find_next
		current_pos = 7
		while !valid_password? || @passwords.include?(@password)
			letter = @password[current_pos]
			@password[current_pos] = @letters[(@letters.index(letter) + 1) %
						@letters.length]
			if letter == "z" 
				current_pos -= 1
			else
				current_pos = 7
			end
		end
		@passwords.push(@password.clone)
	end

	def valid_password?
		return three_straight? && 
			(!@password.include?("i") && !@password.include?("o") &&
				!@password.include?("l")) &&
			two_unique_pairs?
	end

	def three_straight?
		pos = 0
		while pos < @letters.length - 2
			if @password.include?(@letters[pos..pos + 2].join)
				return true
			end
			pos += 1
		end
		return false
	end

	# non-overlapping pairs
	def two_unique_pairs?
		pairs = 0
		pos = 0
		while pos < @password.length - 1
			if @password[pos] == @password[pos + 1]
				pairs += 1
				pos += 1
			end
			pos += 1
		end
		return pairs >= 2
	end

	def output
		puts "#{@password}"
	end

end

Part1.new("input.txt")