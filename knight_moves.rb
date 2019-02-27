class Knight
  attr_accessor :moves, :location, :parent

  def initialize(location, parent)
    @location = location
    @parent = parent
    move
  end

  def move
    @moves = []
    x = @location[0]
    y = @location[1]

    if x - 1 > -1 && y - 2 > -1
      @moves << [x - 1, y - 2]
    end
    if x + 1 < 8 && y - 2 > -1
      @moves << [x + 1, y - 2]
    end
    if x - 1 > -1 && y + 2 < 8
      @moves << [x - 1, y + 2]
    end
    if x + 1 < 8 && y + 2 < 8
      @moves << [x + 1, y + 2]
    end

    if x - 2 > -1 && y - 1 > -1
      @moves << [x - 2, y - 1]
    end
    if x + 2 < 8 && y - 1 > -1
      @moves << [x + 2, y - 1]
    end
    if x - 2 > -1 && y + 1 < 8
      @moves << [x - 2, y + 1]
    end
    if x + 2 < 8 && y + 1 < 8
      @moves << [x + 2, y + 1]
    end
  end
end

def knight_moves(startpoint, endpoint)
  queue = []
  queue << Knight.new(startpoint, nil)
  counter = 0
  while queue[0].location != endpoint
    queue[0].moves.each do |move|
      queue << Knight.new(move, queue[0])
    end
    queue.shift
    counter += 1
  end
  output = []
  while queue[0].location != startpoint
    output << queue[0].location
    queue[0] = queue[0].parent
  end
  output << startpoint
  output.reverse!
  return "Found after #{counter} moves. #{output}"
end

print knight_moves([0, 0], [7, 2])
