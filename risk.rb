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

  def single_roll
    @this_roll = @o_dice1.sample
    @this_roll
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

class Territories
  def initialize
    @alaska = 0
    @alberta = 0
    @central_america = 0
    @eastern_us = 0
    @greenland = 0
    @northwest_territory = 0
    @ontario = 0
    @quabec = 0
    @western_us = 0
  end

  def get_victory_number(country_count, continent)
    if country_count > 9
      continent = 7
    elsif country_count == 7 or country_count == 9
      continent = 5
    elsif country_count == 6
      continent = 3
    elsif country_count == 4
      continent = 2
    end          
    continent
  end  

  def north_america
    get_victory_number(9, @north_america_victory_count)
  end  

  def south_america
    get_victory_number(4, @south_america_victory_count)
  end

  def australia   
    get_victory_number(4, @australia_victory_count)
  end  

  def asia
    get_victory_number(12, @asia_victory_count)
  end
  
  def africa
    get_victory_number(6, @aftric_victory_count)
  end

  def europe 
    get_victory_number(7, @europe_victory_count)
  end

  def board
  end 

end 

class Cards
  def initialize
  end
  
  def draw
  end

  def turn_in(amount_of_cards, cards_array)

  end
end

class Players
  def initialize
  end  
end  


class PlayGame
  def initialize
    @dice = Dice.new
  end
  
  def roll_dice(o_players, d_players)
    @dice.get_winner(o_players, d_players)
  end  
end


game = PlayGame.new
puts "how many players does the offense have?"
o_player_num = gets.chomp.to_i
puts "How many players does the defense have?"
d_player_num = gets.chomp.to_i
game.roll_dice(o_player_num, d_player_num)
stuff = Territories.new