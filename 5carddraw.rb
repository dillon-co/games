
values = (1..10).to_a + ["11(Jack)", "12(Queen)", "13(King)", "14(Ace)"]

deck = { "clubs" => values,
         "diamonds" => values,
         "hearts" => values,
         "spades" => values }

hand1suit = []
hand2suit = []

@@var = 0


hand1 = []
hand2 = []

5.times do # This makes the suits of each hand
  hand1suit << deck.keys.sample.to_s
  hand2suit << deck.keys.sample.to_s 
end


5.times do # Creates the values of the cards.

  hand1 << deck[deck.keys.sample].sample
  hand2 << deck[deck.keys.sample].sample
end



def two_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |card| 
    h[card] += 1
    if h[card] == 2 && h.keys.uniq.length >= 3
      @var = 1
      return true
    end               
  end  
end



def two_pair(hand)
  if hand.uniq.length == 3 && two_of_a_kind(hand) == true
    @var = 2
  end  
end 



def three_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |e| 
    h[e] += 1
    unless h[e] == 4 
      if h[e] == 3
        @var = 3
        return true
      end  
    end
  end
end       
    

def four_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |e| 
    h[e] += 1 
    if h[e] == 4
      @var = 6
    end
  end
end  



# Check if lowest card to highest card go in consecutive order(I.E. 2,3,4,5,6)
def straight(hand)
  @new_arr = []
  @numbers = hand.map { |card| card.to_i }
  @numbers.sort!
  @new_arr << @numbers[0]
  until @new_arr[-1] == @new_arr[0] + 4
    @new_arr << @new_arr[-1] + 1
  end
  if @new_arr == @numbers 
    return true
    @var = 4
  end  
end



#Checks if all suits are the same
def flush(hand)
  if hand.uniq.length == 1
    return true
    @var = 5
  end     
end



# Checks for a a straight and a flush
def straight_flush(hand, suit)
  if flush(suit) == true && straight(hand) == true
    @var = 7
  end  
end



# Checks for a straight flush with cards value 10 and higher
def royal_flush(hand, suit)
  if straight(hand) == true && flush(suit) == true && hand.each { |card| card.to_i >= 10 }
    @var = 8 
  end  
end  



def full_house(hand)
  if hand.uniq.length == 2 && two_of_a_kind(hand) == true && three_of_a_kind(hand) == true
    @var = 9
  end 
end 



# Checks everything.
def what_happened(hand, suit)
  two_of_a_kind(hand)
  three_of_a_kind(hand)
  four_of_a_kind(hand)
  straight(hand)
  flush(suit)
  straight_flush(hand, suit)
  royal_flush(hand, suit)
  full_house(hand)
  two_pair(hand)

  if @var == 9
    puts "My God It's A Full House!!"
  elsif @var == 8
    puts "MOTHER OF GOD, ITS A ROYAL FLUSH!!!!"
  elsif @var == 7
    puts "Jesus Crist It's a straight flush!"
  elsif @var == 6
    puts "Four of a kind with #{e}"
  elsif @var == 5 
    puts "Flush with #{suit[0]}!" 
  elsif @var == 4
    puts "Straight! from #{@new_arr[0]} to #{@new_arr[-1]}"
  elsif @var == 3
    puts "Three of a kind"
  elsif @var == 2
    puts "TWO PAIR!!"
  elsif @var == 1  
    puts "Pair!!"    
  end  
end 

p hand1suit
p hand1
what_happened(hand1, hand1suit)

puts ""

p hand2suit
p hand2
what_happened(hand2, hand2suit)
