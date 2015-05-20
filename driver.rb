class Player
  attr_accessor :lives, :number_of_lives, :position, :position_height
  def initialize(length, number_of_lives=10)
    @lives = number_of_lives
    @length = length
    @position = length/2
    @position_height = length-1
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
    "<>"
  end  

  def life_count
    @lives
  end  
  
  def move_left
    @position -= 1
  end

  def move_right
    @position += 1
  end  
end

class Board
  attr_accessor :board, :blocks, :field, :boardwidth, :boardheight
  def initialize(length, lives)
    @blocks = "[]"
    @field =  "  "
    @boardwidth = length
    @boardheight = length 
    @board = Array.new(length) {Array.new (length) {@field}}
  end
  
  def update  
    @board.unshift(Array.new(@boardwidth) { rand(10) == 1 ? @blocks : @field})
    @board.pop
  end
end    

class CubeRunner
  attr_accessor :player
  def initialize(length, speed, lives)
    @length = length
    @player = ::Player.new(length, lives)
    @lives = @player.life_count
    @board = ::Board.new(length, lives)
    @start_position = ::Player.new(length, lives).position_height
    @row_pos = ::Player.new(length, lives).position
    @speed = speed
  end
  
  def detect_colision(pos)
    @position = @start_position
    if @board.board[@position][pos] == @board.blocks
      @player.hit
    end
  end

  def draw
    system 'clear' or system 'cls'
    @board.board.each_with_index do |cord, x|
      cord.each_with_index do |pos, y|                              
        @board.board[@start_position][@row_pos] = @player.image
        print "#{@board.board[x][y]}"
      end
      puts ""
    end
    # I Guess it's good to take a break every once in a while.... This is too damn simple..
    puts (@player.life_bar_image * @player.lives)
  end

  def movement_ai(pos)
    if @board.board[@start_position-2][pos] == @board.blocks && (@board.board[@start_position-2][pos+1] == @board.blocks || @board.board[@start_position-2][pos-1] == @blocks)
      rand(2) == 1 ? @player.move_right : @player.move_left
    end
    if @board.board[@start_position-1][pos] == @board.blocks
      if @board.board[@start_position-1][pos-1] == @board.blocks || @board.board[@start_position][pos-1] == @board.blocks
        @player.move_right
      elsif @board.board[@start_position-1][pos+1] == @board.blocks || @board.board[@start_position][pos+1] == @board.blocks
        @player.move_left
      else
        rand(2) == 1 ? @player.move_right : @player.move_left
      end
    end
    detect_colision(pos)
  end

  def run
    @board.update
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

game = CubeRunner.new(30, 0.03, 10)
puts game.play