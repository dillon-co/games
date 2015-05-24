class Dice
  def initialize
    @o_dice1 = [1, 2, 3, 4, 5, 6]
    @o_dice2 = [1, 2, 3, 4, 5, 6]
    @o_dice3 = [1, 2, 3, 4, 5, 6]

    @d_dice1 = [1, 2, 3, 4, 5, 6]
    @d_dice2 = [1, 2, 3, 4, 5, 6]

    @o_dice_array = [@o_dice1, @o_dice2, @o_dice3]
    @d_dice_array = [@d_dice1, @d_dice2]
  end
  
  def roll
    @o_roll_array = []
    @d_roll_array = []
    @o_dice_array.each do |o_dice|
      @o_roll_array << o_dice.sample
    end
    
    @d_dice_array.each do |d_dice|
      @d_roll_array << d_dice.sample
    end

    puts "The offense has rolled a #{@o_roll_array[0]}, #{@o_roll_array[1]} and a #{@o_roll_array[2]}"
    puts "The defense has rolled a #{@d_roll_array[0]} and #{@d_roll_array[1]}"
  end  

  def get_winner(o_players, d_players)
    o_victory_count = 0
    d_victory_count = 0

    if o_players <= 1
      puts "The Defense has won this battle with a #{d_players} soldigers left"
    elsif d_players <= 0
      puts "THE offense has won this battle with #{o_players} soldigers left."  
    else  
      roll
      @o_roll_array.each do |o_die|
        @d_roll_array.each do |d_die|
          if o_die > d_die
            o_victory_count += 1
          else
            d_victory_count += 1
          end
        end
      end  
      puts o_victory_count
      puts d_victory_count
      if o_victory_count > d_victory_count
        puts "The offense has won this roll!"
        d_players-= 2
      elsif d_victory_count > o_victory_count && o_victory_count > 0 || o_victory_count == d_victory_count
        puts "This roll is a Tie!"
        o_players -= 1
        d_players -= 1
      else
        puts "The defense has won this roll!"
        o_players -= 2
      end 
      puts "The offense has #{o_players} \n The defense has #{d_players}"
      sleep 0.5 
      get_winner(o_players, d_players)
    end
  end  
end  

dice = Dice.new
puts "how many players does the offense have?"
o_player_num = gets.chomp.to_i
puts "How many players does the defense have?"
d_player_num = gets.chomp.to_i
dice.get_winner(o_player_num, d_player_num)