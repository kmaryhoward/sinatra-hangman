class Game
    require 'yaml'

    attr_accessor :word, :board, :message
    @@guesses = [] 
    @@turns = 4

    def intialize
      @word = @word
      @board = @board
      @message = @message
    end
  
    def word
      selected_word = File.readlines('data/dictionary.txt')
      @word = selected_word.select { |line| line.length <= 12 && line.length >= 5 }.sample.downcase
    end
  
    def board(guess)     
      puts guess
      @@guesses.push(guess)
      puts @word
      @board = @word.chars.map {|l| @@guesses.include?(l) ? l : " _ "}
      new_demo = @board.pop
      @board.join
    end

    def turn(guess)
      @@turns -= 1
      puts @@turns
      if @@turns < 4 && @board.include?(" _ ") && @word.include?(guess)
         @message = "Congrats! #{guess} belongs in the secret word. Take another turn – you have #{@@turns + 1} left!"
      elsif 
         @@turns < 4 && !@board.include?(" _ ")
         @message = "You won!!"
      else
         @message = "Too bad. Take another turn – you have #{@@turns + 1} left!"     
    end 
     
    end
   
    def game_over?
      @@turns == 0
    end

    def reset
      @@turns = 4
      @@guesses = []
    end

    def saved
      num = Random.new
      i = num.rand(10)
      save_file = File.open("games/game-#{i}", "w+")
      save_file.write(YAML.dump(self))
      save_file.close
      @message = "Your saved number is #{i}"
    end

    def load(num) 
      game = YAML.load(File.read("games/game-#{num}"))
      @message = "Your game has been reloaded!" 
    end
    
  end
