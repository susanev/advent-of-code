# susan evans
# last edited 12/15/2016
# advent of code 2016, day 123, part 1

# constructs the room with walls using a formula
# finds the shortest path from START to GOAL
# Thanks to http://www.redblobgames.com/pathfinding/a-star/introduction.html for the path finding tutorial 

class Part1
  CONST_HEIGHT = 45
  CONST_WIDTH = 45
  CONST_START = [1, 1]
  CONST_GOAL = [39, 31]

  def initialize(file_name)
    @fav_num = File.open(file_name, "r").first.to_i
    build_grid
    @map = [CONST_START]
    @came_from = {CONST_START => nil}
    @path = [CONST_GOAL]
    find_locations
    find_path
    output
  end

  def build_grid
    @grid = Array.new(CONST_HEIGHT)
    CONST_HEIGHT.times do |y|
      @grid[y] = Array.new(CONST_WIDTH)
      CONST_WIDTH.times do |x|
        bin = (x * x + 3 * x + 2 * x * y + y + y * y + @fav_num).to_s(2)
        bin.scan(/1/).count % 2 == 0 ? @grid[y][x] = "." : @grid[y][x] = "#";
      end
    end
  end

  def display_grid
    CONST_HEIGHT.times do |y|
      CONST_WIDTH.times do |x|
        print "#{@grid[y][x]} "
      end
      print "\n"
    end
  end

  def find_locations
    while is_not_goal(current = @map.pop)
      get_neighbors(current[0], current[1]).each do |neighbor|
        if !@came_from.include? neighbor
          @map.push(neighbor)
          @came_from[neighbor] = current
        end
      end
    end
  end

  def is_not_goal(current)
    return current.nil? || current == CONST_GOAL ? nil : current
  end

  def get_neighbors(x, y)
    neighbors = []
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy| 
      neighbors.push([x + dx,y + dy]) if valid_cell(x + dx, y + dy)
    end
    return neighbors
  end

  def valid_cell(x, y)
    return x > -1 && x < CONST_WIDTH && 
            y > -1 && y < CONST_HEIGHT && 
            @grid[x][y] == "."
  end

  def find_path
  	current = CONST_GOAL
  	while current != CONST_START
  		current = @came_from[current]
  		@grid[current[0]][current[1]] = "O"
  		@path.push(current)
  	end
  end

  def output
    display_grid
    puts "#{@path.length} is the fewest steps required to reach (#{CONST_GOAL[0]}, #{CONST_GOAL[1]})"
  end
end

Part1.new("input.txt")