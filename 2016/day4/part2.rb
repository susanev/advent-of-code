class Part2
	def initialize(file_name)
		@letters = "abcdefghijklmnopqrstuvwxyz".split("")
		@sector_id = -1
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			while @sector_id == -1
				line = f.gets
				sector_id = line[/\d+/].to_i
				room_name = line[/[a-z]*(-[a-z]+)*/].split("")
				room_name.each_with_index do |letter, index|
					if letter == "-"
						room_name[index] = " "
					else
						room_name[index] = @letters[(@letters.index(letter) + sector_id) % @letters.length]
					end
				end
				if room_name.join.include? "northpole"
					@sector_id = sector_id
				end
			end
		end
	end

	def output
		puts "The sector id is #{@sector_id}"
	end
end

Part2.new("input.txt")