class Player
    
  attr_accessor :hand, :score, :isStanding, :name
  
  def initialize
    @score = 0
    @isStanding = false
    @hand = mkHand(mkSideDeck)
    @name = mkName
  end
  
  def mkHand (aValidSideDeck)
    @hand = aValidSideDeck.shuffle!.pop(4)
  end
  
  def mkSideDeck
    deck = Array.new
    puts "Select 10 cards with values from -10 to 10, excluding 0, to be in your side deck."
    while deck.length < 10
      userInput = gets.chomp!.to_i
      deck.push(userInput) if verifiedSideDeckCard(userInput)
    end
    deck
  end
  
  def verifiedSideDeckCard(aCard)
    cardIsInvalid = false
    cardIsInvalid = true if aCard == 0 || aCard > 10 || aCard < -10
    if cardIsInvalid
      puts "That card has a value greater than 10, smaller than -10, or equal to 0. Please pick a different card."
      return false
    end
    true
  end
  
  def mkName
    puts "What is your name?"
    @name = gets.chomp!.capitalize!
  end
  
end