class Lane
  attr_accessor :log, :car, :space, :lane, :river 
  def initialize
    @log = "=="
    @car = "%%"
    @space = "  "
    @safe_lane = Array.new(@size*2) {"__"}
    @lane = Arr.new(10)
    @river = Arr.new(10)
  end  
  
  def create_row(frequency, object)
    Array.new(size*2) {rand(frequency) == 1 ? object : space}
  end  
  
  def tick_row(row, object, frequency, speed)
    row.unshift(rand(frequency) == 1 ? object : space)
    row.pop
    sleep speed
  end    
end  


class Board
  attr_accessor :board, :size
  def initialize(size)
    @size = size
    @board = create_board
  end  


  def create_board
    Array.new(@size) {
    if rand(3) == 1
      rand(2) == 1 ? lane : river
    else
      safe_lane
    end  
    } 
  end  

  def draw_board
    board.each_with_index do |row, y|
      row.each_with_index do |col, x|
        print "#{board[y][x]}"
      end
      puts ""  
    end  
    puts "LIFE BAR GOES HERE"
  end

  def tick_game(frequency1, frequency2)
  end  

end  

class Character
  attr_accessor :image
  def initialize
    @image = "πø"
  end 
end  

b = Board.new(20)


def play(game)
  while true
    game.draw_board
    game.tick_game(3, 4)
    puts 
  end
end  

play(b)