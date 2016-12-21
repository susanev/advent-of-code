# susan evans
# last edited 12/21/2016
# advent of code 2016, day 21, part 2

# answer: fbhaegdc
class Part2
	CONST_ORI_PASSWORD = "fbgdceah"

	def initialize(file_name)
		@instrs = []
		@password = CONST_ORI_PASSWORD.split("")
		process_file(file_name)
		process_instrs
		output
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				@instrs.push(line)
			end
		end
	end

	def process_instrs
		until @instrs.empty?
			line = @instrs.pop
			if line.include? "swap position"
				line = line.split(" ")
				swap_position(line[2].to_i, line[5].to_i)
			elsif line.include? "swap letter"
				line = line.split(" ")
				swap_letter(line[2], line[5])
			elsif line.include? "rotate left"
				line = line.split(" ")
				rotate_right(line[2].to_i)
			elsif line.include? "rotate right"
				line = line.split(" ")
				rotate_left(line[2].to_i)
			elsif line.include? "rotate based"
				line = line.split(" ")
				rotate_based(line[6])
			elsif line.include? "reverse"
				line = line.split(" ")
				reverse(line[2].to_i, line[4].to_i)
			elsif line.include? "move"
				line = line.split(" ")
				move(line[2].to_i, line[5].to_i)
			else
				puts "Bad instruction: #{line}"
			end
		end
	end

	def swap_position(pos1, pos2)
		@password[pos1], @password[pos2] = @password[pos2], @password[pos1] 
	end

	def swap_letter(char1, char2)
		swap_position(@password.index(char1), @password.index(char2))
	end

	def rotate_left(amt)
		amt.times do
			temp = @password[0]
			(0...@password.length - 1).each do |pos|
				@password[pos] = @password[pos+ 1]
			end
			@password[@password.length - 1] = temp
		end
	end

	def rotate_right(amt)
		amt.times do
			temp = @password[@password.length - 1]
			pos = @password.length - 1
			while pos > 0
				@password[pos] = @password[pos- 1]
				pos -= 1
			end
			@password[0] = temp
		end
	end

	def rotate_based(rot_char)
		rot_amt = find_times(@password.index(rot_char))
		rotate_left(rot_amt)
	end

	def reverse(pos1, pos2)
		rev = @password[pos1, pos2 - pos1 + 1].reverse!
		(pos1..pos2).each do |curr_index|
			@password[curr_index] = rev[curr_index - pos1]
		end
	end

	def move(to, from)
		if from < to
			temp = @password[from]
			(from...to).each do |pos|
				@password[pos] = @password[pos + 1]
			end
			@password[to] = temp
		else
			temp = @password[from]
			until from == to
				@password[from] = @password[from - 1]
				from -= 1
			end
			@password[to] = temp
		end
	end

	def find_times(curr)
		rot_index = 0
		rot_amt = 1 + rot_index
		rot_amt += 1 if rot_index >= 4
		until (rot_index + rot_amt) % @password.length == curr
			rot_index += 1
			rot_amt = 1 + rot_index
			rot_amt += 1 if rot_index >= 4
		end
		return rot_amt
	end

	def output
		puts "#{CONST_ORI_PASSWORD} unscrambled is #{@password.join}"
	end
end

Part2.new("input.txt")