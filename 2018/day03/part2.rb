class Part2
	def initialize(file_name)
		@area = {}
		@no_overlap = []
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				process(line.scan(/\d*/).reject(&:empty?).
						map(&:to_i))
			end
		end
	end

	def process(line)
		# id, left, top, width, height
		overlap = false
		for i in line[1]...(line[1]+line[3])
			for j in line[2]...(line[2]+line[4])
				if @area[[i,j]]
					@no_overlap.delete(@area[[i,j]])
					@area[[i,j]] = "X"
					overlap = true
				else
					@area[[i,j]] = line[0]
				end
			end
		end
		if !overlap
			@no_overlap.push(line[0])
		end
	end

	def output
		puts "#{@no_overlap[0]}"
	end
end

Part2.new("input.txt")
