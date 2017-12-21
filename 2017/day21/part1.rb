# susan evans
# last edited 12/20/2017
# advent of code 2017, day 21, part 1

class Part1
	def initialize(file_name)
		@matrix = [".", "#", ".", ".", ".", "#", "#", "#", "#"]
		@rules = {}
		processFile(file_name)
		stuff = []
		four_split(@rules[@matrix]).each do |item|
			stuff += four_split(@rules[@rules[item]])
		end

		count = 0
		stuff.each do |section|
			count += @rules[@rules[section]].count("#")
		end
		puts count
		 
		# count = @rules[@rules["####".split("")]].count("#") +
		# 		@rules[@rules[".###".split("")]].count("#") +
		# 		@rules[@rules["####".split("")]].count("#") +
		# 		@rules[@rules["#.#.".split("")]].count("#") +
		# 		@rules[@rules["####".split("")]].count("#") +
		# 		@rules[@rules[".###".split("")]].count("#") +
		# 		@rules[@rules["####".split("")]].count("#") +
		# 		@rules[@rules["#.#.".split("")]].count("#") +
		# 		@rules[@rules["....".split("")]].count("#") +
		# 		@rules[@rules["####".split("")]].count("#") +
		# 		@rules[@rules[".#..".split("")]].count("#") +
		# 		@rules[@rules[".#..".split("")]].count("#") +
		# 		@rules[@rules["###.".split("")]].count("#") +
		# 		@rules[@rules["#..#".split("")]].count("#") +
		# 		@rules[@rules["...#".split("")]].count("#") +
		# 		@rules[@rules["#...".split("")]].count("#")
		#puts count
		output
	end

	def processFile(file_name)
		line_index = 0
		File.open(file_name, "r") do |f|
			f.each_line do |line|
				line = line.chomp.delete("//").split(" => ")
				find = line[0].split("")
				if find.length == 4
					perms = [find]
					perms += two_by_rotations(find)
					flips = two_by_flip(find)
					perms += flips
					flips.each do |flip|
						perms += two_by_rotations(flip)
					end
					perms.uniq
					perms.each do |perm|
						@rules[perm] = line[1].split("")
					end
				else
					perms = [find]
					perms += three_by_rotations(find)
					flips = three_by_flip(find)
					perms += flips
					flips.each do |flip|
						perms += three_by_rotations(flip)
					end
					perms.uniq
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

	def two_by_flip(arr)
		flips = []

		first = arr.clone
		first.insert(0, first.delete_at(1))
		first.insert(arr.length - 1, first.delete_at(2))
		flips.push(first)

		second = arr.clone
		second.insert(0, second.delete_at(3))
		second.insert(0, second.delete_at(3))
		flips.push(second)
		return flips
	end

	def two_by_rotations(arr)
		rotations = []

		first = arr.clone
		first.insert(arr.length - 1, first.delete_at(1))
		first.insert(0, first.delete_at(1))
		rotations.push(first)

		rotations.push(arr.reverse)

		third = arr.clone
		third.insert(0, third.delete_at(3))
		third.insert(0, third.delete_at(2))
		rotations.push(third)
		return rotations
	end

	def three_by_flip(arr)
		flips = []

		flips.push([arr[6], arr[7], arr[8], arr[3], arr[4], arr[5], arr[0], arr[1], arr[2]])
		flips.push([arr[2], arr[1], arr[0], arr[5], arr[4], arr[3], arr[8], arr[7], arr[6]])
		return flips
	end

	def three_by_rotations(arr)
		rotations = []

		rotations.push([arr[6], arr[3], arr[0], arr[7], arr[4], arr[1], arr[8], arr[5], arr[2]])
		rotations.push(arr.reverse)
		rotations.push([arr[2], arr[5], arr[8], arr[1], arr[4], arr[7], arr[0], arr[3], arr[6]])
		return rotations
	end

	def output
		puts "#{}"
	end
end

Part1.new("input.txt")
