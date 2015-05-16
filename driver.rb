class Player
  attr_accessor :lives
  def initialize(length, number_of_lives=10)
    @lives = number_of_lives
    @length = length
  end

  def alive?
    @lives > 0
  end

  def hit
    @lives -= 1
  end

  def image
    '/\\'
  end

  def life_bar_image
    Array.new(@lives, "|=")
  end  

  def life_count
    @lives
  end    
end

class Board
  attr_accessor :player
  def initialize(length, lives)
    @blocks = "[]"
    @field =  "  "
    @boardwidth = length
    @boardheight = length 
    @board = Array.new(length) {Array.new (length) {@field}}
    @player = ::Player.new(length, lives)
  end
  
  def update  
    @board.unshift(Array.new(@boardwidth) { rand(3) == 1 ? @blocks : @field})
    life_bar(@boardwidth)
    @board.pop
  end

  def board
    @board
  end 

  def blocks
    @blocks
  end
  
  def field
    @field
  end

  def life_bar(pos)
    player.life_bar_image.each_with_index do |health, h_index|
      @board[pos-1][h_index] = health
    end    
  end  
end    

class CubeRunner
  def initialize(length, speed, lives)
    @length = length
    @lives = lives
    @player = ::Board.new(length, lives).player 
    @board_items = ::Board.new(length, lives)
    @board = @board_items.board
    @start_position = (length-1)
    @row_pos = length / 2
    @speed = speed
  end
  
  def detect_colision(pos)
    @position = @start_position
    if @board[@position][pos] == @board_items.blocks
      @player.hit
    end
    @board[@position][pos] = @player.image
  end

  def draw
    system 'clear' or system 'cls'
    @board.each_with_index do |cord, x|
      cord.each_with_index do |pos, y|
        print "#{@board[x][y]}"
      end
      puts ""
    end
  end

  def move_left(pos)
    @board[@start_position][pos], @board[@start_position][pos-1] = @board[@start_position][pos-1], @board[@start_position][pos]
    @row_pos = (pos-1)
  end

  def move_right(pos)
    @board[@start_position][pos], @board[@start_position][pos+1] = @board[@start_position][pos+1], @board[@start_position][pos]
    @row_pos = (pos+1)
  end


  def movement_ai(pos)
    if @board[@start_position-2][pos] == @board_items.blocks && (@board[@start_position-2][pos+1] == @board_items.blocks || @board[@start_position-2][pos-1] == @blocks)
      rand(2) == 1 ? move_right(pos) : move_left(pos)
    end
    if @board[@start_position-1][pos] == @board_items.blocks
      if @board[@start_position-1][pos-1] == @board_items.blocks || @board[@start_position][pos-1] == @board_items.blocks
        move_right(pos)
      elsif @board[@start_position-1][pos+1] == @board_items.blocks || @board[@start_position][pos+1] == @board_items.blocks
        move_left(pos)
      else
        rand(2) == 1 ? move_right(pos) : move_left(pos)
      end
    end
    detect_colision(pos)
  end

  def run
    @board_items.update
  end

  def play
    while @player.alive?
      run
      movement_ai(@row_pos)
      draw
      sleep (@speed)
    end
  end
end

game = CubeRunner.new(30, 0.03, 2)
puts game.play