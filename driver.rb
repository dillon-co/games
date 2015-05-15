class Player
  def initialize(number_of_lives=10)
    @lives = number_of_lives
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
    hit
    bar = "=" * @lives
    @bar_array = bar.split('')
  end  

  def life_bar_array
    @bar_array
  end  
end

class Board
  def initialize(length)
    @blocks = "[]"
    @field =  "  "
    @boardwidth = length
    @boardheight = length 
    @board = Array.new(length) {Array.new (length) {@field}}
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

  def life_bar
    ::Player.new.life_bar_array.to_a.each_with_index do |health, index|
      @board[1][index] = health
    end  
  end  
end    

class CubeRunner
  def initialize(length, speed)
    @length = length
    @player = ::Player.new(2)
    @board_items = ::Board.new(length)
    @board = @board_items.board
    @start_position = (length-1)
    @row_pos = length / 2
    @speed = speed
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

  def run
    @board.unshift(Array.new(@length) { rand(15) == 1 ? @board_items.blocks : @board_items.field})
    @board.pop
  end

  def detect_colision(pos)
    @position = @start_position
    if @board[@position][pos] == @board_items.blocks
      @player.hit
    end
    @board[@position][pos] = @player.image
    @board_items.life_bar
  end

  def move_left(pos)
    @board[@start_position][pos], @board[@start_position][pos-1] = @board[@start_position][pos-1], @board[@start_position][pos]
    @row_pos = (pos-1)
  end

  def move_right(pos)
    @board[@start_position][pos], @board[@start_position][pos+1] = @board[@start_position][pos+1], @board[@start_position][pos]
    @row_pos = (pos+1)
  end

  def move(pos)
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

  def play
    while @player.alive?
      move(@row_pos)
      draw
      run
      sleep (@speed)
    end
  end
end

game = CubeRunner.new(30, 0.03)
puts game.play