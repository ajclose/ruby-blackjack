require_relative 'deck'
class Player

  attr_accessor :money, :hand, :turn

  def initialize
    @money = 100
    @hand = []
  end

  def start_hand
    @hand = []
    @turn = true
  end

  def assign_value
    values = @hand.map do |card|
      case card
      when "K"
        "10"
      when "Q"
        "10"
      when "J"
        "10"
      when "A"
        "A"
      else
        card.to_s
      end
    end
  end

  def calculate_hand
    total = 0
    values = assign_value
    values.sort!
    values.each do |card|
      if card == "A"
        if total <= 10
          total += 11
        else
          total += 1
        end
      else
        total += card.to_i
      end
    end
    total
  end

end
