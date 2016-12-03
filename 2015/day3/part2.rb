class Part1
	def initialize(file_name)
		@houses = { 0 => [0]}
		@santa_location = [0, 0]
		@robo_location = [0, 0]
		processFile(file_name)
		output
	end

	def processFile(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				directions = line.split("")
				processDirs(directions)
			end
		end
	end

	def processDirs(directions)
		directions.each_with_index do |direction, index|
			location = @santa_location
			if index % 2 == 1 
				location = @robo_location
			end

			if direction == '^'
				location[1] += 1
			elsif direction == 'v'
				location[1] -= 1
			elsif direction == '>'
				location[0] += 1
			else # '<'
				location[0] -= 1
			end
			
			arr = @houses[location[0]]
			if arr.nil?
				@houses[location[0]] = [location[1]]
			elsif !arr.include?(location[1])
				arr.push(location[1])
			end
		end
	end

	def output
		puts "#{@houses.reduce(0) { |count, (key, value)| count += 1 + value.length - 1 }} houses receive at least one present"
	end
end

Part1.new("input.txt")