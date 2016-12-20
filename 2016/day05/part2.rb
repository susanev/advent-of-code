class Part2
	require 'digest/md5'

	CONST_ZEROS = "00000"
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
					until (md5 = Digest::MD5.hexdigest(line + num.to_s))[0..4] == CONST_ZEROS && 
							CONST_VALID.include?(i = md5[5]) && 
							@password[i = i.to_i].nil?
						num += 1
					end
					@password[i] = md5[6]
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