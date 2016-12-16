# susan evans
# last edited 12/12/2016
# advent of code 2016, day 13, part 2

# finds all reachable locations from START
# in MAX_STEPS steps or less
# Thanks to http://www.redblobgames.com/pathfinding/a-star/introduction.html for the path finding tutorial 

class Part2
  CONST_HEIGHT = 25
  CONST_WIDTH = 25
  CONST_START = [1, 1]
  CONST_MAX_STEPS = 50

  def initialize(file_name)
    @fav_num = File.open(file_name, "r").first.to_i
    build_grid
    @map = [CONST_START]
    @came_from = {CONST_START => nil}
    @cost_so_far = {CONST_START => 0}
    # starts at 1 to include starting location
    @locations = 1
    find_locations
    #count_locations
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
    # sets starting location to visited
    @grid[CONST_START[0]][CONST_START[1]] = "O"
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
    while @map.length > 0
      current = @map.pop
      get_neighbors(current[0], current[1]).each do |neighbor|
        new_cost = @cost_so_far[current] + 1
        if !@came_from.include?(neighbor) && !@cost_so_far.include?(neighbor) &&  new_cost <= CONST_MAX_STEPS
          @grid[neighbor[0]][neighbor[1]] = "O"
          @cost_so_far[neighbor] = new_cost
          @map.push(neighbor)
          @came_from[neighbor] = current
        end
      end
    end
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

  def output
    display_grid
    puts "#{@cost_so_far.length} distinct x,y coordinates from #{CONST_START[0]},#{CONST_START[1]}"
  end
end

Part2.new("input.txt")