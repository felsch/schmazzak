class Schmazzak
  
  def initialize
    @gameOver = false
    @playerScore = 0
    schmazzakGame
  end

  def schmazzakGame
    puts "---------------------"
    puts "The game has started!"
    @mainDeck = mkMainDeck
    @playerHand = mkPlayerHand
    @board = mkBoard
    while !@gameOver
      schmazzakTurn(@mainDeck, @playerHand, @board)
    end
    puts "You win!" if @playerScore == 20
    puts "You suck! Your final score is #{@playerScore}." if @playerScore > 20
    puts "Well, at least you didn't go *over* 20... but not anywhere near it, either. " if @playerScore < 20
    puts "The game is over. Thanks for playing."
  end

  def schmazzakTurn(mainDeck, playerHand, board)
    puts "--------------------------"
    puts "The next turn has started."
    puts "The player's current score is #{@playerScore}."
    puts "Do you want to draw a card from the main deck? [y/n]"
    if gets.chomp! == 'y'
      puts "The player wants to draw a card from the main deck."
      puts "The player draws #{board.push(mainDeck.pop).last}. The board is now #{board}"
      puts "The player's score is now #{evalScore(board)}."
      puts "Do you want to play a card from your hand? [y/n]"
      if gets.chomp! == 'y'
        puts "Your hand is #{playerHand}. Which card do you want to play?"
        @chosenCard = gets.chomp!.to_i
        puts "The player wants to play a #{@chosenCard}"
        if verifyChosenCard(@chosenCard, playerHand)
          puts "That card is in your deck."
          puts "Removing #{playerHand.delete(@chosenCard)} from the player's hand."
          puts "Adding #{@chosenCard} to the board."
          board.push(@chosenCard)
          puts "Your hand is now #{@playerHand}."
          puts "The board is now #{board}."
        else
          puts "That card is not in your deck."
        end
      else
        puts "The player does not want to play a card from his hand."
      end
      schmazzakTurn(mainDeck, playerHand, board) unless evalScore(board) > 20
    else 
      puts "The player is done. His final score is #{evalScore(board)}."
    end
    @gameOver = true
  end
  
  def mkMainDeck
    @deck = Array.new(10)
    @deck = ((@deck.fill {|i| i=i+1}).*4).shuffle!
    #puts "The main deck is #{@deck.inspect}."
    @deck
  end
  
  def mkSideDeck
    @deck = Array.new
    puts "Select 10 cards with values ranging from -10 to 10 to be in your side deck."
    10.times do
      @elementToAdd = gets.chomp!.to_i
      @deck.push(@elementToAdd)
    end
    puts "Your selected side deck is #{@deck}."
    if verifySideDeck(@deck)
      puts "Your Deck is invalid. Pick new cards."
      mkSideDeck
    end
    puts "Your Deck is valid."
    @deck
  end
  
  def verifySideDeck (sideDeckArray)
    @deckInvalid = false
    sideDeckArray.each do |element|
      @deckInvalid = true if element > 10 || element < -10 || element == 0
    end
    puts "One or more of your cards has a value greater than 10 or smaller than -10." if @deckInvalid
    @deckInvalid
  end
  
  def mkPlayerHand
    puts "Player Hand is being made."
    @sideDeck = mkSideDeck
    @playerHand = @sideDeck.shuffle!.pop(4)
    puts "Your randomly selected hand is #{@playerHand}."
    @playerHand
  end
  
  def mkBoard
    @board = Array.new
  end
  
  def evalScore (boardArray)
    @playerScore = 0
    boardArray.each do |element|
      @playerScore = @playerScore + element
    end
    @playerScore
  end
  
  def verifyChosenCard (chosenCard, playerHand)
    true unless playerHand.index(chosenCard) == nil
  end
  
end

Schmazzak.new