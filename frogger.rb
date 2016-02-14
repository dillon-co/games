class Lane
  attr_accessor :size, :safe_lane, :challenging_lanes 
  def initialize(size)
    @size = size
    @safe_lane = Array.new(size) {".."}
    @challenging_lanes = {
          :road => {
             :safe_symbol => " _",
             :danger_symbol => "%%",
          }, 
          :river => {
              :safe_symbol => "==",
              :danger_symbol => "^^",
            }
    }        
  end  
  
  def create_row(frequency, row)
    Array.new(size) {rand(frequency) == 1 ? row[:danger_symbol] : row[:safe_symbol]}
  end  
end  


class Board
  attr_accessor :size, :lane, :safe_lane, :road, :river, :board
  def initialize(size, difficulty)
    @size = size
    @lane = Lane.new(size)
    @safe_lane = lane.safe_lane
    @road = lane.create_row(difficulty, lane.challenging_lanes[:road])
    @river = lane.create_row(difficulty, lane.challenging_lanes[:river])
    @board = board_init
  end  


  def board_init 
    board_arr = []
    lane.safe_lane
    3.times do
      board_arr << safe_lane.dup
    end  
    number_of_hard_lanes = size-3
    hard_lane_section = number_of_hard_lanes/2 - 2
    hard_lane_section.times do 
      board_arr << choose_hard_lane.dup
    end 
    3.times do 
     board_arr << safe_lane.dup 
    end 
    hard_lane_section.times do 
      board_arr << choose_hard_lane.dup
    end  
    3.times do 
      board_arr << safe_lane.dup
    end  
    board_arr
  end   

  def choose_hard_lane
    if rand(5) == 1 || rand(2) == 1 
        road
      else  
        river
      end  
  end  

  def draw_board
    width = board.flatten.max.to_s.size+2
    puts board.map { |a| a.map { |i| i.to_s.rjust(width) }.join}
    puts ""
    puts "LIFE BAR GOES HERE"
    sleep 0.1
  end
  
  def tick_row(row, row_type)
    row.unshift(rand(4) == 1 ? row_type[:danger_symbol] : row_type[:safe_symbol])
    row.pop
  end

  def tick
    draw_board
    board.each do |row|
      if [" _", "%%"].include?(row[0])
        tick_row(row, lane.challenging_lanes[:road])
      elsif ["==", "^^"].include?(row[0])
        tick_row(row, lane.challenging_lanes[:river])
      end  
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