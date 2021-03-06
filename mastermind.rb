
module Mastermind
  class Computer
    def generate_code
      @available_num = [1, 2, 3, 4, 5, 6]
      code = ""
      6.times do
        code += @available_num[rand(6)].to_s
      end
      return code
    end

    def generate_guess(choice, feedback_code)
      available_spots = [0, 1, 2, 3, 4, 5]
      stored_ones = []
      stored_twos_i = []
      new_code = choice.split("")
      new_code.each_with_index do |num, i|
        if feedback_code[i] == "1"
          stored_ones.push(num)
          #checks for 0's that are not duplicates. computer does not care if it guesses more of a num than required.
        elsif feedback_code[i] == "0" && !stored_ones.include?(num)
          @available_num.delete(num)
        elsif feedback_code[i] == "2"
          stored_twos_i.push(i)
        end
      end
      stored_twos_i.each { |i| available_spots.delete(i) }
      while stored_ones.length > 0
        stored_index = available_spots[rand(available_spots.length)]
        available_spots.delete(stored_index)
        new_code[stored_index] = stored_ones.pop
      end
      available_spots.each do |i|
        new_code[i] = @available_num[rand(@available_num.length)]
      end
      return new_code.join
    end
  end

  class Player
    def enter_code
      code = gets.chomp
      until code =~ /^[1-6]{6}$/
        puts "Enter a valid input"
        code = gets.chomp
      end
      return code
    end
  end

  class Game
    def initialize
      @guesses_left = 12
      @player_score = 0
      @computer_score = 0
      @choice = ""
      @player = Player.new
      @computer = Computer.new
      puts "New game START"
      self.new_game
    end

    def display_prompt
      if @game_type == "guess"
        puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
        puts "Guesses left = #{@guesses_left}"
        puts "Enter a six digit code"
        puts "Feedback: 0 means no hit, 1 means right number wrong place, 2 means correct"
        @choice = @player.enter_code
      elsif @game_type == "code"
        if @guesses_left == 12
          @choice = @computer.generate_code
        else
          @choice = @computer.generate_guess(@choice, self.feedback(@choice))
        end
      end
    end

    def check_status
      if self.feedback(@choice) == "222222"
        if @game_type == "guess"
          @player_score += 1
          puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
        else
          @computer_score += 1
          puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
        end
        @guesses_left = 12
        puts "Guesser wins! Starting new game"
        self.new_game
      elsif self.feedback(@choice) != "222222"
        @guesses_left -= 1
        if @guesses_left < 0
          if @game_type == "guess"
            @computer_score += 1
            puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
          else
            @player_score += 1
            puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
          end
          @guesses_left = 12
          puts "Coder wins! Starting new game"
          self.new_game
        elsif @game_type == "guess"
          puts self.feedback(@choice)
        else
          puts "Computer guesses #{@choice}"
          puts self.feedback(@choice)
        end
      end
    end

    def new_game
      puts "Enter guess to begin guessing role, code to create code for computer to guess."
      @game_type = gets.chomp
      until @game_type =~ /^guess$|^code$/
        puts "Enter a valid input"
        @game_type = gets.chomp
      end
      if @game_type == "guess"
        @code = @computer.generate_code
      else
        puts "Enter your code!"
        @code = @player.enter_code
      end
    end

    def feedback(guess_code)
      feedback_code = "000000"
      check_for_correct(guess_code, feedback_code)
      check_for_wrong_spot(guess_code, feedback_code)
      return feedback_code
    end

    def check_for_correct(guess_code, feedback_code)
      (0..5).each do |x|
        if guess_code[x] == @code[x]
          feedback_code[x] = "2"
        end
      end
    end

    def check_for_wrong_spot(guess_code, feedback_code)
      #checks duplicates in case there are more than in code
      duplicates = {}
      (1..6).each do |num|
        (0..5).each do |index|
          if num.to_s == @code[index] && guess_code[index] != @code[index]
            if duplicates[num] == nil
              duplicates[num] = 1
            else
              duplicates[num] += 1
            end
          end
        end
      end
      (0..5).each do |i|
        if guess_code[i] != @code[i]
          duplicates.each do |x, y|
            if guess_code[i].to_i == x && y > 0
              duplicates[x] = y - 1
              feedback_code[i] = "1"
            end
          end
        end
      end
    end

    def game_loop
      while true
        self.display_prompt
        self.check_status
      end
    end
  end
end

include Mastermind
game = Game.new
game.game_loop
