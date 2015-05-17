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
    "|="
  end  

  def life_count
    @lives
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
    @board.unshift(Array.new(@boardwidth) { rand(15) == 1 ? @blocks : @field})
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
    @start_position = (length-1)
    @row_pos = length / 2
    @speed = speed
  end
  
  def detect_colision(pos)
    @position = @start_position
    if @board.board[@position][pos] == @board.blocks
      @player.hit
    end
    @board.board[@position][pos] = @player.image
  end

  def draw
    system 'clear' or system 'cls'
    @board.board.each_with_index do |cord, x|
      cord.each_with_index do |pos, y|                              
        print "#{@board.board[x][y]}"
      end
      puts ""
    end
    # I Guess it's good to take a break every once in a while.... This is too damn simple..
    puts (@player.life_bar_image * @player.lives)
  end

  def move_left(pos)
    @board.board[@start_position][pos], @board.board[@start_position][pos-1] = @board.board[@start_position][pos-1], @board.board[@start_position][pos]
    @row_pos = (pos-1)
  end

  def move_right(pos)
    @board.board[@start_position][pos], @board.board[@start_position][pos+1] = @board.board[@start_position][pos+1], @board.board[@start_position][pos]
    @row_pos = (pos+1)
  end


  def movement_ai(pos)
    if @board.board[@start_position-2][pos] == @board.blocks && (@board.board[@start_position-2][pos+1] == @board.blocks || @board.board[@start_position-2][pos-1] == @blocks)
      rand(2) == 1 ? move_right(pos) : move_left(pos)
    end
    if @board.board[@start_position-1][pos] == @board.blocks
      if @board.board[@start_position-1][pos-1] == @board.blocks || @board.board[@start_position][pos-1] == @board.blocks
        move_right(pos)
      elsif @board.board[@start_position-1][pos+1] == @board.blocks || @board.board[@start_position][pos+1] == @board.blocks
        move_left(pos)
      else
        rand(2) == 1 ? move_right(pos) : move_left(pos)
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