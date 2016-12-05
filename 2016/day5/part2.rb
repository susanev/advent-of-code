class Part2
	require 'digest/md5'

	CONST_VALID = "01234567"

	def initialize(file_name)
		@password = Array.new(8)
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				num = 0
				while @password.include? nil do 
					until Digest::MD5.hexdigest(line + num.to_s)[0..4] == "00000"
						num += 1
					end
					hash_index = Digest::MD5.hexdigest(line + num.to_s)[5]
					if CONST_VALID.include? hash_index
						hash_index = hash_index.to_i
						if @password[hash_index].nil?
							@password[hash_index] = Digest::MD5.hexdigest(line + num.to_s)[6]
						end
					end
					num += 1
				end
			end
		end
	end

	def output
		puts "the password is #{@password.join}"
	end
end

Part2.new("input.txt")