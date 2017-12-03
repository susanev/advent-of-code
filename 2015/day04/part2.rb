class Part2
	require 'digest/md5'

	def initialize(file_name)
		@answer = 0
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				until Digest::MD5.hexdigest(line + @answer.to_s)[0..5] == "000000"
					@answer += 1
				end
			end
		end
	end

	def output
		puts "the answer is #{@answer}"
	end
end

Part2.new("input.txt")