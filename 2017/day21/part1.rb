# susan evans
# last edited 12/20/2017
# advent of code 2017, day 21, part 1

class Part1
	def initialize(file_name)
		@matrix = [".", "#", ".", ".", ".", "#", "#", "#", "#"]
		@rules = {}
		processFile(file_name)
		arr = four_split(@rules[@matrix])
		arr.each_with_index do |item, item_index|
			arr[item_index] = @rules[item]
		end
		puts arr.flatten.count("#")

		arr.each_with_index do |item, item_index|
			arr[item_index] = four_split(@rules[item])
		end
		puts arr.flatten.count("#")

		arr.each_with_index do |item, item_index|
			item.each_with_index do |item2, item2_index|
				arr[item_index][item2_index] = four_split(@rules[item2])
			end
		end
		puts arr.flatten.count("#")

		arr.each_with_index do |item, item_index|
			item.each_with_index do |item2, item2_index|
				item2.each_with_index do |item3, item3_index|
					arr[item_index][item2_index][item3_index] = @rules[item3]
				end
			end
		end
		print arr
		puts arr.flatten.count("#")
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.delete("//").split(" => ")
				find = line[0].split("")
				if find.length == 4
					perms = two_by_rotations(find)
					perms.each do |perm|
						@rules[perm] = line[1].split("")
					end
				else
					perms = three_by_rotations(find)
					perms.each do |perm|
						@rules[perm] = line[1].split("")
					end
				end
			end
		end
	end

	def four_split(arr)
		split = []
		split.push([arr[0], arr[1], arr[4], arr[5]])
		split.push([arr[2], arr[3], arr[6], arr[7]])
		split.push([arr[8], arr[9], arr[12], arr[13]])
		split.push([arr[10], arr[11], arr[14], arr[15]])
		return split
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
		rotations.push([arr[2], arr[1], arr[0], arr[5], arr[4], arr[3], arr[8], arr[7], arr[6]])
		return rotations.uniq
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
