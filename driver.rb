@player = '/\\'
@life = true
@boardwidth = 30
@boardheight = 30
@blocks = "[]"
@field =  "  "
@board = Array.new(@boardheight) {Array.new (@boardwidth) {@field}} 
@start_position = (@boardheight-1)

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

def position(pos)
  @position = @start_position
  if @board[@position][pos] == @blocks
    @life =  false
  end  
  @board[@position][pos] = @player
end 


def play 
  while @life == true
    draw
    run
    position(15)
    sleep 0.05
  end
end


play  