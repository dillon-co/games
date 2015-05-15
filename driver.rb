class Player
  def initialize(number_of_lives=10)
    @lives = number_of_lives
  end

  def life_count
    @lives
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
    "=="
  end  
end

class Board
  def initialize(length, life_length)
    @blocks = "[]"
    @field =  "  "
    @boardwidth = length
    @boardheight = length 
    @board = Array.new(length) {Array.new (length) {@field}}
    @player = ::Player.new(life_length)
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
    @board[pos][0...@player.life_count].each_with_index do |item, index|
      @board[pos][index] = @player.life_bar_image
    end 
  end  
end    

class CubeRunner
  def initialize(length, speed, life_number)
    @length = length
    @player = ::Player.new(2)
    @board_items = ::Board.new(length, life_number)
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
    @board_items.life_bar(@start_position)
    @board.pop
  end

  def detect_colision(pos)
    @position = @start_position
    if @board[@position][pos] == @board_items.blocks
      @player.hit
    end
    @board[@position][pos] = @player.image
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

game = CubeRunner.new(30, 0.03, 10)
puts game.play