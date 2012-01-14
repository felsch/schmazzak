class Game
  
  def initialize
    player1 = mkPlayer('1')
    player2 = mkPlayer('2')
    @players = [player1, player2]
    @mainDeck = mkMainDeck
    puts "--------------"
    puts "A match of Schmazzak between #{@players[0].name} and #{@players[1].name} has begun!"
    game
  end
  
  def game
    while @players[0].score < 20 && @players[1].score < 20 && !(@players[0].isStanding && @players[1].isStanding)
      puts "--------------"
      puts "A new round has started."
      gameTurn
    end
    puts "The game is over!"
    determineWinner
  end
  
  def gameTurn
    @players.each do |currentPlayer|
      puts "--------------"
      puts "It's #{currentPlayer.name}'s turn."
      puts "#{currentPlayer.name}'s board is #{currentPlayer.board}, with a score of #{currentPlayer.score}"
      if !currentPlayer.isStanding
        puts "#{currentPlayer.name} draws a #{currentPlayer.board.push(@mainDeck.pop).last} from the main deck."
        puts "Your board is now #{currentPlayer.board}. Do you want to play a card from your hand? [y/n]"
        if gets.chomp! == 'y'
          puts "Your hand is #{currentPlayer.hand}. Which card do you want to play?"
          chosenCard = gets.chomp!.to_i
          if currentPlayer.hand.find(chosenCard)
            currentPlayer.board.push(chosenCard)
            currentPlayer.hand.delete(chosenCard)
            puts "#{currentPlayer.name} plays #{chosenCard} from his hand."
          end
        end
        puts "Your score is #{currentPlayer.score}, your remaining hand is #{currentPlayer.hand}."
        puts "Do you want to stand? (You can not draw or play any more cards once you're standing.) [y/n]"
          if gets.chomp! == 'y'
            currentPlayer.isStanding = true
          end
    end
  end
    
    @players[0].score = 20 ## DELETE THIS WHEN DONE
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
    
    if @players[0].score > 20 && @players[1].score > 20
      puts "Tie!"
    end
    
    if @players[0].score <=20 && @players[1].score <= 20
      puts "#{@players[0].name} wins with a score of #{@players[0].score}." if @players[0].score > @players[1].score
      puts "#{@players[1].name} wins with a score of #{@players[1].score}." if @players[0].score < @players[1].score
    end
    
    if @players[0].score <= 20 && @players[1].score > 20
      puts "#{@players[0].name} wins with a score of #{@players[0].score}."
    end
    
    if @players[0].score > 20 && @players[1].score <= 20
      puts "#{@players[1].name} wins with a score of #{@players[1].score}."
    end
    
  end
  
end

class Player
    
  attr_accessor :hand, :score, :isStanding, :name, :board
  
  def initialize
    @score = 0
    @isStanding = false
    @name = mkName
    @hand = mkHand(mkSideDeck)
    @board = Array.new
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
  
  def score
    score = 0
    @board.each {|element| score+=element  }
    return score
  end
  
end

Game.new