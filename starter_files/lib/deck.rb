require_relative "card"

class Deck
  def initialize
    @cards = []
    %i(hearts spades clubs diamonds).each do |suit|
      face = (2..10).to_a + %w(A J Q K)
      face.each do |f|
        @cards << Card.new(f, suit)
      end
    end
    @cards = @cards.shuffle
  end

  def deal
    @cards.shift
  end
end
