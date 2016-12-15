# susan evans
# last edited 12/12/2016
# advent of code 2016, day 13, part 2

# finds all reachable locations, does not count
# within the 50 range yet

class Part2
  CONST_HEIGHT = 25
  CONST_WIDTH = 25
  CONST_MAX_PATH = 50
  CONST_NEIGHBORS = [[1, 0], [-1, 0], [0, 1], [0, -1]]

  def initialize(file_name)
    @fav_num = File.open(file_name, "r").first.to_i
    build_grid

    @map = [[1, 1], 0]
    @visited = {[1 ,1] => true}
    find_locations
    output
  end

  def build_grid
    @grid = Array.new(CONST_HEIGHT)
    @grid.length.times do |i|
      @grid[i] = Array.new(CONST_WIDTH)
    end
    CONST_HEIGHT.times do |y|
      CONST_WIDTH.times do |x|
        bin = (x * x + 3 * x + 2 * x * y + y + y * y + @fav_num).to_s(2)
        if x == 31 && y == 39
          @grid[y][x] = "?"
        elsif bin.scan(/1/).count % 2 == 0
          @grid[y][x] = "."
        else
          @grid[y][x] = "#";
        end
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
    while @map.length > 0
      current = @map.pop
      get_neighbors(current[0], current[1]).each do |neighbor|
        if !@visited.include? neighbor
          @grid[neighbor[0]][neighbor[1]] = "O"
          @map.push(neighbor)
          @visited[neighbor] = true
        end
      end
    end
  end

  def get_neighbors(x, y)
    neighbors = []
    CONST_NEIGHBORS.each do |dx, dy| 
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
    puts "#{@visited.length}"
  end
end

Part2.new("input.txt")