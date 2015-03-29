
values = (1..10).to_a + ['Jack', 'Queen', 'King', 'Ace']

deck = { "clubs" => values,
         "diamonds" => values,
         "hearts" => values,
         "spades" => values }

hand1 = []
hand2 = []

5.times do 
  hand1 << deck[deck.keys.sample].sample
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


def straight(hand)
  sorted_hand = hand.sort
  
end

# Checks everything.
def what_happened(hand)
  two_of_a_kind(hand)
  three_of_a_kind(hand)
  four_of_a_kind(hand)
  straight(hand)
end  

p hand1
what_happened(hand1)

puts ""

p hand2
what_happened(hand2)
   