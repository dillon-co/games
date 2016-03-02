
require 'io/console'
require 'io/wait'
class Lane
  attr_accessor :size, :type, :lane, :frequency, :lane_symbols
  def initialize(size, type, frequency)
    @size = size
    @type = type
    @lane_symbols = symbols_for_lane
    @frequency = frequency
    @lane =  {
      :lane_obj => new_row,
      :fps => frequency,
      :time_since_last_tick => 0,
    }
  end

  def new_row
    Array.new(size) {rand(frequency) == 1 ? lane_symbols[:danger_symbol] : lane_symbols[:safe_symbol]}
  end

  def symbols_for_lane
    case type
    when :safe
      {
        :safe_symbol => "..",
        :danger_symbol => "xx",
      }
    when :road
      {
        :safe_symbol => " _",
        :danger_symbol => "%%",
      }
    when :river
      {
        :safe_symbol => "==",
        :danger_symbol => "^^",
      }
    end
  end

  def tick
    lane[:lane_obj].unshift(rand(frequency) == 1 ? lane_symbols[:danger_symbol] : lane_symbols[:safe_symbol])
    lane[:lane_obj].pop
    lane[:time_since_last_tick] = 0
    lane[:lane_obj]
  end
end

class Board
  attr_accessor :size, :board, :lanes
  def initialize(size, difficulty)
    @size = size
    @lanes = board_init
    @board = board_from_lanes
    @board_ticks = 0
  end

  def board_init
    board_arr = []
    3.times do
      board_arr << Lane.new(size, :safe, 0)
    end
    number_of_hard_lanes = size-3
    hard_lane_section = number_of_hard_lanes/2 - 2
    hard_lane_section.times do
      board_arr << Lane.new(size, choose_hard_lane, 4)
    end
    3.times do
      board_arr << Lane.new(size, :safe, 0)
    end
    hard_lane_section.times do
      board_arr << Lane.new(size, choose_hard_lane, 4)
    end
    3.times do
      board_arr << Lane.new(size, :safe, 0)
    end
    board_arr
  end

  def choose_hard_lane
    if rand(2) == 1
      :road
    else
      :river
    end
  end

  def board_from_lanes
    lanes.map { |lane| lane.lane[:lane_obj].dup }
    # Using dup here so the board doesn't hold a reference to the Lane object
  end

  def draw_board(player)
    width = board.flatten.max.to_s.size+2
    board.each { |lane| lane[:time_since_last_tick] += 1}
    @board_ticks += 1
    system "clear" or system "cls"
    puts board.map { |lane| lane.map { |cell| cell.to_s.rjust(width) }.join }
    puts ""
    puts "LIFE BAR GOES HERE"
    puts "Position[#{player[:position][:y]}][#{player[:position][:x]}]"
    puts "#{@board_ticks} boards drawn"
    # system "stty -raw echo"
     sleep 0.001
  end

  def tick(player)
    system 'clear' 
    draw_board(player)
    lanes.each_with_index do |lane, index|
      @board[index] = lane.tick.dup
      # Using dup here so the board doesn't hold a reference to the Lane object
    end
  end

end

class Character
  attr_accessor :player
  def initialize(size)
    @player = {
      :position => {:y => -1, :x => (size/2)-1},
      :image => "πø"
    }
  end


  def move(input)
    puts "LLol\e[31m#{input}\e[0m"
    raise 'a' if input != nil && input != ""
    if input == 'i'
      @player[:position][:y] = @player[:position][:y] - 1
    elsif input == 'j'  
      @player[:position][:x] = @player[:position][:x] - 1
    elsif input == 'l'
      @player[:position][:x] =  @player[:position][:x] + 1
    elsif input == 'k'
      @player[:position][:y]  = @player[:position][:y] + 1    
    elsif input == 'q'
      exit
    end      
  end  
end

b = Board.new(30, 4)
c = Character.new(30)


def play(game, player)
  while true
    game.board[(player.player[:position][:y])][(player.player[:position][:x])] = player.player[:image]
    game.tick(player.player)
  end
end

prompt = Thread.new do 
  loop do 
    # system "stty raw -echo"
    c.move(s = STDIN.getch.downcase)
  end  
end
play(b, c)
