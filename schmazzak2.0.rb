class Game
  
  def initialize
    player1 = mkPlayer('1')
    player2 = mkPlayer('2')
    @players = [player1, player2]
    @mainDeck = mkMainDeck
    @board = Array.new
    puts "--------------"
    puts "A match of Schmazzak between #{@players[0].name} and #{@players[1].name} has begun!"
    game
  end
  
  def game
    while @players[0].score < 20 && @players[1].score < 20
      puts "--------------"
      puts "A new round has started."
      gameTurn(@players)
    end
    determineWinner
  end
  
  def gameTurn (playersArray)
    puts "The next turn has started."
    
    playersArray.each do |currentPlayer|
      # make player turns here
    end
    
    @players[0].score = 20
  end
  
  def mkPlayer(val)
    puts "Initializing Player #{val}."
    Player.new
  end
  
  def mkMainDeck
    deck = (((Array.new(10)).fill {|i| i+=1}).*4).shuffle!
  end
  
  def determineWinner
    puts "The winner is being determined."
    # evaluate scores and determine winner here
  end
  
end

class Player
    
  attr_accessor :hand, :score, :isStanding, :name
  
  def initialize
    @score = 0
    @isStanding = false
    @name = mkName
    @hand = mkHand(mkSideDeck)
  end
  
  def mkHand (aValidSideDeck)
    @hand = aValidSideDeck.shuffle!.pop(4)
  end
  
  def mkSideDeck
    deck = Array.new
    puts "#{@name}, select 10 cards with values from -10 to 10, excluding 0, to be in your side deck."
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
    mkName unless @name
    @name
  end
  
end

puts Game.new.inspect