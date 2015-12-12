# loop do
#   Draw board
#   get player input
#   check for winners
#   computer move
#   check for winners
# end








@board_array = Array.new(3)  {Array.new(3, '-')}    
@spaces_array = ['0 0', '0 1', '0 2', '1 1', '1 2' '1 3', '2 0', '2 1', '2 2']


def draw
  @board_array.each do |y|
    y.each do |x|
      print "#{x} "
    end 
    puts ""
   end   
end  
  
def get_input
  puts "Where do you want to go?"
  @answer = gets.chomp
  @answer = @answer.split(' ')
  if @answer[0] == 'top'
    @answer[0] = 0
  elsif @answer[0] == 'middle'
    @answer[0] = 1
  elsif @answer[0] == 'bottom' 
    @answer[0] = 2
  else 
    puts "That is not a valid answer. Try again."
    get_input  
  end
  if @answer[1] == 'left'
    @answer[1] = 0 
  elsif @answer[1] == 'right'
    @answer[1] = 2
  elsif @answer[1] == 'middle'
    @answer[1] = 1
  else 
    puts "That is not a valid answer. Try again."
    get_input  
  end          
end  

def place_char(char, answer)
  @board_array[answer[0]][answer[1]] = char
  @spaces_array.each do |x|
    if x == answer.join(' ')
      @spaces_array.delete(x)
    end
  end    
end  

def computer_input
  comp_space = @spaces_array.sample.split(' ')
  @board_array[comp_space[0].to_i][comp_space[1].to_i] = 'o'
  @spaces_array.each do |x|
    if x == comp_space.join(' ')
      @spaces_array.delete(x)
    end
  end    
end  


while true
  draw
  get_input
  place_char('x', @answer)
  draw
  print "Ok, I choose"
  sleep 1
  print ' .'
  sleep 1
  print ' .'
  sleep 1 
  print " .\n"
  sleep 1
  computer_input
  puts "\n\n"
end
