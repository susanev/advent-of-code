# susan evans
# last edited 12/12/2016
# advent of code 2016, day 123, part 1

class Part1
  CONST_HEIGHT = 25
  CONST_WIDTH = 25
  CONST_FAV_NUM = 1364
  CONST_MAX_PATH = 50

  def initialize(file_name)
    @grid = Array.new(CONST_HEIGHT)
    @grid.length.times do |i|
      @grid[i] = Array.new(CONST_WIDTH)
    end
    @points = {}
    build_grid
    find_path(1, 1, 0)

    sum = 0
    puts @points
    @points.each do |k,v|
      sum += v.length
    end
    puts sum
    display_grid
    #process_file(file_name)  
    #output
  end

  def process_file(file_name)
    File.open(file_name, "r") do |f|
      f.each_line do |line|

      end
    end
  end

  def build_grid
    CONST_HEIGHT.times do |y|
      CONST_WIDTH.times do |x|
        bin = (x * x + 3 * x + 2 * x * y + y + y * y + CONST_FAV_NUM).to_s(2)
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

  def output
    puts ""
  end

  def find_path (x, y, d)
    if x < 0 || x > CONST_WIDTH - 1 || y < 0 || y > CONST_HEIGHT - 1
      return false
    elsif @grid[y][x] != "."
      return false
    elsif d == CONST_MAX_PATH
      return true
    else
      if @points[x].nil?
        @points[x] = [y]
      elsif !@points[x].include? y
        @points[x].push(y)
      end
      @grid[y][x] = "O"
      find_path(x + 1, y, d + 1)
      find_path(x - 1, y, d + 1)
      find_path(x, y + 1, d + 1)
      find_path(x, y - 1, d + 1)
      return true
    end
  end
end

Part1.new("input2.txt")