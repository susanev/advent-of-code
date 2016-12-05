class Part1
	require 'digest/md5'

	def initialize(file_name)
		@password = ""
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				num = 0
				8.times do 
					until Digest::MD5.hexdigest(line + num.to_s)[0..4] == "00000"
						num += 1
					end
					@password += Digest::MD5.hexdigest(line + num.to_s)[5].to_s
					num += 1
				end
			end
		end
	end

	def output
		puts "the password is #{@password}"
	end
end

Part1.new("input.txt")