class CubeRunner
  def initialize(length)
    @player = '/\\'
    @life = true
    @boardwidth = length
    @boardheight = length
    @blocks = "[]"
    @field =  "  "
    @board = Array.new(@boardheight) {Array.new (@boardwidth) {@field}} 
    @start_position = (@boardheight-1)
    @row_pos = length / 2
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
    @board.unshift(Array.new(@boardwidth) { rand(15) == 1 ? @blocks : @field})
    @board.pop
  end 

  def fix_it(pos)
    if @life == false
      

  def detect_colision(pos)
    @position = @start_position
    if @board[@position][pos] == @blocks
      @life =  false
    end  
    @board[@position][pos] = @player
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
    if @board[@start_position-2][pos] == @blocks && (@board[@start_position-2][pos+1] == @blocks || @board[@start_position-2][pos-1] == @blocks)
      rand(2) == 1 ? move_right(pos) : move_left(pos)
    end
    if @board[@start_position-1][pos] == @blocks
      if @board[@start_position-1][pos-1] == @blocks || @board[@start_position][pos-1] == @blocks
        move_right(pos)
      elsif @board[@start_position-1][pos+1] == @blocks || @board[@start_position][pos+1] == @blocks
        move_left(pos)
      else 
        rand(2) == 1 ? move_right(pos) : move_left(pos) 
      end   
    end  
    detect_colision(pos)
  end 


  def play 
    while @life == true     
      move(@row_pos)
      draw
      run
      sleep 0.05
    end
  end
end

game = CubeRunner.new(30)
puts game.play