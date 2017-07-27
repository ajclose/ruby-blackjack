require "./lib/player"
require "./lib/deck"

puts "Hello and welcome to the game of Blackjack.  Let's begin!"

player = Player.new
dealer = Player.new

while player.money > 0

  system("clear")
  puts "BLACKJACK"
  deck = Deck.new
  winner = false
  player.start_hand
  dealer.start_hand

  2.times do
    player.hand.push(deck.deal.rank)
    dealer.hand.push(deck.deal.rank)
  end

puts "You have $#{player.money} and bet $10"
  player_value = player.calculate_hand
  dealer_value = dealer.calculate_hand

  if player_value == 21 && dealer_value < 21
    puts "You have a #{player.hand.join(", ")}.  Your total is #{player_value}.  BLACKJACK!"
    winner = "player"
    player.turn = false
    dealer.turn = false
  elsif player_value < 21 && dealer_value == 21
    puts "Dealer has a #{dealer.hand.join(", ")}.  BLACKJACK! Dealer wins!"
    winner = "dealer"
    player.turn = false
    dealer.turn = false
  elsif player_value == 21 && dealer_value == 21
    puts "You and the dealer have BLACKJACK!  It's a push!"
    player.turn = false
    dealer.turn = false
  end

  while player.turn == true
    puts "You have a #{player.hand.join(", ")}.  Your total is #{player_value}."

    choice_made = false
    unless choice_made == true
      puts "Do you want to (h)it or (s)tand?"
      choice = gets.chomp
      if choice[0].downcase == "h"
        puts "You hit."
        player.hand.push(deck.deal.rank)
        choice_made = true
      elsif choice[0].downcase == "s"
        puts "You Stand.  Your total is #{player_value}"
        choice_made = true
        player.turn = false
      end
    end
    player_value = player.calculate_hand

    if player_value > 21
      puts "You have a #{player.hand.join(", ")}.  Your total is #{player_value}. You bust, dealer wins!"
      winner = "dealer"
      player.turn = false
      dealer.turn = false
    end

  end

  while dealer.turn == true
    puts "Dealer has a #{dealer.hand.join(", ")}.  Dealer total is #{dealer_value}"
    if dealer_value < 17
      puts "Dealer hits."
      dealer.hand.push(deck.deal.rank)
    else
      puts "Dealer stands."
      dealer.turn = false
    end
    dealer_value = dealer.calculate_hand

    if dealer_value > 21
      puts "Dealer has a #{dealer.hand.join(", ")}.  Dealer total is #{dealer_value}.  Dealer busts, you win!"
      dealer.turn = false
      winner = "player"
    end
  end

  if winner == false
    if player_value > dealer_value
      puts "You win!"
      winner = "player"
    elsif player_value < dealer_value
      puts "Dealer Wins!"
      winner = "dealer"
    else
      puts "Push!"
    end
  end

  if winner == "player"
    player.money += 10
  elsif winner == "dealer"
    player.money -= 10
  end

  deal_again_choice = false

  while deal_again_choice == false
    puts "Deal again? (y/n)"
    deal = gets.chomp
    if deal[0].downcase == "n"
      winnings = player.money - 100
      puts "Thanks for playing!"
      if winnings > 0
        puts "You won $#{winnings}. The Pit Manager would like to speak with you in the back office!"
      elsif winnings < 0
        puts "You lost $#{winnings.abs}! Come back soon!"
      else
        puts "You broke even, better luck next time!"
      end
      exit
    elsif deal[0].downcase == "y"
      deal_again_choice = true
    end
  end


end

puts "Game over, you ran out of money.  LEAVE NOW."
