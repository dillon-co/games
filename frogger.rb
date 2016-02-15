class Lane
  attr_accessor :size, :type, :lane, :frequency, :lane_symbols
  def initialize(size, type, frequency)
    @size = size
    @type = type
    @lane_symbols = symbols_for_lane
    @frequency = frequency
    @lane = new_row
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
    lane.unshift(rand(frequency) == 1 ? lane_symbols[:danger_symbol] : lane_symbols[:safe_symbol])
    lane.pop
    lane
  end

end

class Board
  attr_accessor :size, :board, :lanes
  def initialize(size, difficulty)
    @size = size
    @lanes = board_init
    @board = board_from_lanes
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
    lanes.map { |lane| lane.lane.dup }
    # Using dup here so the board doesn't hold a reference to the Lane object
  end

  def draw_board
    width = board.flatten.max.to_s.size+2
    system "clear" or system "cls"
    puts board.map { |lane| lane.map { |cell| cell.to_s.rjust(width) }.join }
    puts ""
    puts "LIFE BAR GOES HERE"
    sleep 0.1
  end

  def tick
    draw_board
    lanes.each_with_index do |lane, index|
      @board[index] = lane.tick.dup
      # Using dup here so the board doesn't hold a reference to the Lane object
    end
    sleep 0.15
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
end

b = Board.new(30, 4)
c = Character.new(30)
puts c.player[:position][:x]

def play(game, player)
  while true
    game.board[(player.player[:position][:y])][(player.player[:position][:x])] = player.player[:image]
    game.tick
  end
end

play(b, c)
