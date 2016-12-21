# susan evans
# last edited 12/10/2016
# advent of code 2016, day 11, part 1

# IN PROGRESS!!

class Part1
	require 'test/unit/assertions'
	include Test::Unit::Assertions
	CONST_ORDER = ["HG", "HM", "LG", "LM"]

	def initialize(file_name)
		@grid = [[". ", "HM", ". ", "LM"],
			 ["HG", ". ", ". ", ". "],
			 [". ", ". ", "LG", ". "],
			 [". ", ". ", ". ", ". "]]
		@current_floor = 0
		find_path
		# tests
		# display_gird
		# process_file(file_name)	
		# output
	end

	def display_gird
		@grid.each do |row|
			row.each do |cell|
				print " #{cell} "
			end
			print "\n"
		end
		puts "---"
	end

	def tests
		# assert_equal(false, valid_move(1, ["HM", "LM"]))
		assert_equal(true, move(1, [". ", "HM", ". ", ". "]))
		display_gird
		assert_equal(true, move(1, ["HG", "HM", ". ", ". "]))
		display_gird
		assert_equal(false, move(-1, ["HG", ". ", ". ", ". "]))
		assert_equal(true, move(-1, [". ", "HM", ". ", ". "]))
		display_gird
		# assert_equal(false, move(1, ["HG"]))
		# assert_equal(false, valid_move(1, ["LM"]))
		# assert_equal(false, valid_move(-1, ["HG"]))
		# assert_equal(true, valid_move(1, ["HG"]))
		# assert_equal(true, valid_move(-1, ["LG"]))
		# assert_equal(true, valid_move(1, ["LG"]))
	end

	def process_file(file_name)
		File.open(file_name, "r") do |f|
			f.each_line do |line|

			end
		end
	end

	def find_path
		until @grid[3] == ["HG", "HM", "LG", "LM"]
			up = all_valid_moves(1)
			down = all_valid_moves(-1)
			if up.nil?
				move(-1, down[0])
			else
				move(1, up[0])
			end
			puts display_gird
		end
	 end

  	def all_valid_moves(dir)
		all = @grid[@current_floor].reject { |item| item == ". " }.combination(2).to_a.concat(@grid[@current_floor].reject { |item| item == ". " }.combination(1).to_a)
		all.each_with_index do |all_items, ai|
			new_all = Array.new(4)
			CONST_ORDER.each_with_index do |order_item, oi|
				if all_items.include? order_item
					new_all[oi] = order_item
				else
					new_all[oi] = ". "
				end
			end
			all[ai] = new_all
		end
		all = all.select { |items| valid_move(dir, items) }
  	end

 	def move(dir, items)
		if valid_move(dir, items)
			items.each do |item|
				if item != ". "
					item_index = @grid[@current_floor].index(item)
					@grid[@current_floor][item_index] = ". "
					@grid[@current_floor + dir][item_index] = item
				end
			end
			@current_floor += dir
			return true
		else
			return false
		end
  	end

	def valid_move(dir, items)
		if (@current_floor == 0 && dir == -1) ||
					(@current_floor == 3 && dir == 1)
			return false
		end
		new_floor = []
		old_floor = []
		@grid[@current_floor].each do |item|
			if !items.include? item
				old_floor.push(item) 
			else
				old_floor.push(". ")
			end
		end
		@grid[@current_floor + dir].each_with_index do |item, i|
			if item == ". "
				new_floor.push(items[i])
			else
				new_floor.push(item)
			end
		end
		return valid_floor(new_floor) && valid_floor(old_floor)
	end

	def valid_floor(items)
		microchips = []
		generators = []
		items.each do |item|
			if item.include? "M"
				microchips.push(item)
			elsif item.include? "G"
				generators.push(item)
			end
		end
		microchips.each do |microchip|
			if !generators.include?("#{microchip[0]}G") && !generators.empty?
				return false
			end
		end
		return true
	end

	def output
		puts ""
	end
end

Part1.new("input.txt")
