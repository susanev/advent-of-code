# susan evans
# last edited 12/05/2018
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
		prev_length = 0
		while prev_length != data.length
			i = 0
			prev_length = data.length
			while i < data.length - 1
				if (data[i].ord - data[i + 1].ord).abs - 32 == 0
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