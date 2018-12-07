# susan evans
# last edited 12/20/2017
# advent of code 2017, day 21, part 1

#39, 51, 137

class Part1
	def initialize(file_name)
		@matrix = ".#...####"
		@rules = {}
		processFile(file_name)

		# iteration 1
		arr = four_split(@rules[@matrix])

		# iteration 2 + 3
		arr.each_with_index do |item, item_index|
			arr[item_index] = @rules[@rules[item]]
		end

		# iteration 4
		new_arr = []
		arr.each_with_index do |item, item_index|
			hold = four_split(item)
			hold.each do |hold_item|
				new_arr.push(@rules[hold_item])
			end
		end

		# iteration 5
		new_arr.each_with_index do |item, item_index|
			new_arr[item_index] = @rules[item]
		end

		print new_arr

		puts new_arr.join.count("#")
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.delete("//").split(" => ")
				find = line[0].split("")
				if find.length == 4
					perms = two_by_rotations(find)
				else
					perms = three_by_rotations(find)
				end
				perms.each do |perm|
					@rules[perm.join] = line[1]
				end
			end
		end
	end

	def four_split(arr)
		arr = arr.split("")
		split = []
		split.push([arr[0], arr[1], arr[4], arr[5]].join)
		split.push([arr[2], arr[3], arr[6], arr[7]].join)
		split.push([arr[8], arr[9], arr[12], arr[13]].join)
		split.push([arr[10], arr[11], arr[14], arr[15]].join)
		return split.clone
	end

	def two_by_rotations(arr)
		rotations = [arr]
		rotations.push([arr[0], arr[2], arr[1], arr[3]])
		rotations.push([arr[1], arr[0], arr[3], arr[2]])
		rotations.push([arr[1], arr[3], arr[0], arr[2]])
		rotations.push([arr[2], arr[0], arr[3], arr[1]])
		rotations.push([arr[2], arr[3], arr[0], arr[1]])
		rotations.push([arr[3], arr[1], arr[2], arr[0]])
		rotations.push(arr.reverse)
		return rotations.uniq
	end

	def three_by_rotations(arr)
		rotations = [arr]
		rotations.push([arr[6], arr[3], arr[0], arr[7], arr[4], arr[1], arr[8], arr[5], arr[2]])
		rotations.push([arr[8], arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]])
		rotations.push([arr[2], arr[5], arr[8], arr[1], arr[4], arr[7], arr[0], arr[3], arr[6]])
		rotations.push([arr[2], arr[1], arr[0], arr[5], arr[4], arr[3], arr[8], arr[7], arr[6]])
		rotations.push([arr[8], arr[5], arr[2], arr[7], arr[4], arr[1], arr[6], arr[3], arr[0]])
		rotations.push([arr[6], arr[7], arr[8], arr[3], arr[4], arr[5], arr[0], arr[1], arr[2]])
		rotations.push([arr[0], arr[3], arr[6], arr[1], arr[4], arr[7], arr[2], arr[5], arr[8]])
		return rotations.uniq
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
