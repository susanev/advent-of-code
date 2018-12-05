# susan evans
# last edited 12/04/2018
# advent of code 2018, day 5, part 2

class Part2
	def initialize(file_name)
		@data = []
		@counts = {}
		processFile(file_name)
		output
	end

	def processFile(file_name)
		letters = "abcdefghijklmnopqrstuvwxyz".split("")
		@data= File.open(file_name, "r").
				readlines[0].split("")
		try = []
		letters.each do |letter|
			@data.each do |piece|
				if !piece.downcase.eql?(letter)
					try.push(piece)
				end
			end
			@counts[process(try)] = letter
			try = []
		end
	end

	def process(data)
		prev_data = []
		while !prev_data.eql?(data)
			i = 0
			prev_data = data.clone
			while i < data.length - 1
				if data[i].downcase.eql?(data[i+1].downcase) &&
						!data[i].eql?(data[i+1])
					data.delete_at(i)
					data.delete_at(i)
				end
				i += 1
			end
		end
		return data.length
	end

	def output
		puts "#{@counts.sort[0][0]}"
	end
end

Part2.new("input.txt")