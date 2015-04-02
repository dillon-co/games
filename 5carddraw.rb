
values = (1..10).to_a + ["11(Jack)", "12(Queen)", "13(King)", "14(Ace)"]

deck = { "clubs" => values,
         "diamonds" => values,
         "hearts" => values,
         "spades" => values }

hand1suit = []
hand2suit = []


hand1 = ["10", "11", "12", "13", "14"]
hand2 = []

5.times do # This makes the suits of each hand
  hand1suit << "clubs"
  hand2suit << deck.keys.sample.to_s 
end


5.times do # Creates the values of the cards.

  # hand1 << deck[deck.keys.sample].sample
  hand2 << deck[deck.keys.sample].sample
end




def two_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |e| 
    h[e] += 1
    unless h[e] == 3 || h[e] == 4 
      if h[e] == 2 
          puts "Two of a kind with #{e}"
      end    
    end        
  end  
end

def three_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |e| 
    h[e] += 1
    unless h[e] == 4 
      if h[e] == 3
        puts "Three of a kind with #{e}"
      end  
    end
  end
end       
    

def four_of_a_kind(hand)
  h = Hash.new(0)
  hand.each do |e| 
    h[e] += 1 
    if h[e] == 4
      puts "Four of a kind with #{e}" 
    end
  end
end      

# Check if lowest card to highest card go in consecutive order(I.E. 2,3,4,5,6)
def straight(hand)
  new_arr = []
  @numbers = hand.map { |card| card.to_i }
  @numbers.sort!
  new_arr << @numbers[0]
  until new_arr[-1] == new_arr[0] + 4
    new_arr << new_arr[-1] + 1
  end
  if new_arr == @numbers 
    puts "Straight! from #{new_arr[0]} to #{new_arr[-1]}"
    return true
  end  
end

#Checks if all suits are the same
def flush(hand)
  if hand[0] == hand[1] &&= hand[2] &&= hand[3] &&= hand[4] 
    puts "Flush with #{hand[0]}!"
    return true
  end     
end



#
def straight_flush(hand, suit)
  puts "Jesus Crist Its A Straight Flush!" if flush(suit) == true && straight(hand) == true
end

def royal_flush(hand) 
  # if  
  #   puts "ITS A ROYAL FLUSH!!!!" if @flush == true && @straight == true
  # end   
end




# Checks everything.
def what_happened(hand, suit)
  two_of_a_kind(hand)
  three_of_a_kind(hand)
  four_of_a_kind(hand)
  straight(hand)
  flush(suit)
  straight_flush(hand, suit)
  royal_flush(hand)
end 

p hand1suit
p hand1
what_happened(hand1, hand1suit)

puts ""

p hand2suit
p hand2
what_happened(hand2, hand2suit)
