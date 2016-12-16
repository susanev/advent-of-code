# susan evans
# last edited 12/15/2016
# advent of code 2016, day 16, part 2

class Part2
	CONST_DISK_SIZE = 35651584

	def initialize(file_name)
		@data = File.open(file_name, "r").first
		generate_data
		find_valid_checksum
		output
	end

	def generate_data 
		until @data.length >= CONST_DISK_SIZE
			next_data = reverse_inverse(@data)
			@data << "0"
			@data << next_data
		end
		@data = @data[0, CONST_DISK_SIZE]
	end

	def reverse_inverse(str)
		new_str = ""
		pos = str.length - 1
		while pos > -1
			new_str << (str[pos] == "0" ? "1" : "0")
			pos -= 1
		end
		return new_str
	end

	def find_valid_checksum
		@checksum = find_checksum(@data)
		until @checksum.length % 2 == 1
			@checksum = find_checksum(@checksum)
		end
	end

	def find_checksum(data)
		pos = 0
		checksum = ""
		while pos < data.length - 1
			checksum << (data[pos] == data[pos + 1] ? "1" : "0")
			pos += 2
		end
		@checksum = checksum
	end

	def output
		puts "The correct check sum is: #{@checksum}"
	end
end

Part2.new("input.txt")
