cards = [(2..10).to_a, 'Jack', 'Queen', 'King', 'Ace'].flatten
suits = %w(Spades Clubs Hearts Diamonds)
deck = []
comp_wins = 0
p_wins = 0

cards.each do |card|
  suits.each do |suit|
    deck << [card, suit]   
  end
end   

while deck.length > 0
  player_card = deck.sample
  deck.delete(player_card)   

  # puts "Player card is #{player_card[0]} of #{player_card[1]}\n" 
  player_card[0] == "Ace" ? player_card[0] = 14 : nil
  player_card[0] == "King" ? player_card[0] = 13 : nil
  player_card[0] == "Queen" ? player_card[0] = 12 : nil
  player_card[0] == "Jack" ? player_card[0] = 11 : nil

  computer_card = deck.sample
  deck.delete(computer_card)

  # puts "Computer card is #{computer_card[0]} of #{computer_card[1]}\n\n"  
  computer_card[0] == "Ace" ? computer_card[0] = 14 : nil
  computer_card[0] == "King" ? computer_card[0] = 13 : nil
  computer_card[0] == "Queen" ? computer_card[0] = 12 : nil
  computer_card[0] == "Jack" ? computer_card[0] = 11 : nil



  if player_card[0].to_i > computer_card[0].to_i
    p_wins += 1
  elsif player_card[0].to_i < computer_card[0].to_i
    comp_wins += 1 
  end 
end   

if deck.length == 0
  puts "player has won #{p_wins} times, Computer has won #{comp_wins}"
  if p_wins > comp_wins
    puts "Player Wins!"
  elsif p_wins < comp_wins
    puts "Computer Wins"
  else
    puts "It's a Tie!"
  end
end

