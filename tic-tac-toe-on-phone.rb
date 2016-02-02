@board = [['-','-','-'],['-', '-','-'],['-','-','-']]
@checker = [[1,1], [1,2], [1,0], [0,0],[0,1],[0,2],[2,0],[2,1],[2,2]]
@player = {symbol: 'X'}
@computer = {symbol: 'O'}
@inputs = {
                'top' => 0, 
                'middle'=>1,
                'bottom'=>2,
                'left'=>0,
                'right'=>2
                }
@game_over = false

def draw_board
    @board.each_with_index do |row, y|
        row.each_with_index do |col, x|
            print " #{@board[y][x]} "
        end
        puts ""
    end
end

def place_mark(player, y, x)
    if @board[y][x] == '-'
        @checker.delete([y,x])
        @board[y][x] = player[:symbol]
    else
        puts "that spot is already taken!"
    end
end

def get_input(player, input)
    input_arr = input.split(' ')
    [player, @inputs[input_arr[0]], @inputs[input_arr[1]]]
end

def player_turn(player)
    puts "where do you want to go?"
    answer = gets.chomp('> ')
    arr = get_input(player, answer)
    place_mark(arr[0], arr[1], arr[2])
end

def computer_turn(computer)
    puts "now the computer goes"
    sleep 1 
    print ". " 
    sleep 1 
    print ". "
    sleep 1
    print ". "
    sleep 1
    puts "\n\n"
    c_turn = @checker.sample
    place_mark(computer, c_turn[0], c_turn[1])
    @checker.delete(c_turn)
end

def play
    unless @game_over
        draw_board
        player_turn(@player)
        draw_board
        computer_turn(@computer)
    end
end

play
