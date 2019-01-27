
There is a computer, player, computer code, guessed code, feedback code, game as a whole, counter for guesses,
display, and prompt. As well as a way to reset and keep track of wins and losses.
module Mastermind
    class Computer
        def generate_code
            code = ""
            6.times do
                code += (1 + rand(6)).to_s
            end
            return code
        end
        def
    end
    class Player
        def enter_code
            code = gets.chomp
            unless guess =~ /^[1-6]{6}$/
                puts "Enter a valid input"
                code = gets.chomp
            end
            return code
        end
    end

    end
    class Game 
        #display new game start
        #keep score between player and computer
        #Keep track of used codes
        #limit the number of codes player can use
        #reset game if win or player resign
        #display game
        def initialize
            @guesses_left = 12
            @player_score = 0
            @computer_score = 0
            @player = Player.new
            @computer = Computer.new
            puts "New game START"
            self.new_game
        end
        def display_prompt(@game_type)
            if game_type == "guess"
                puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
                puts "Guesses left = #{@guesses_left}"
                puts "Enter a six digit code"
                puts "Feedback: 0 means no hit, 1 means right number wrong place, 2 means correct"
                @choice = @player.enter_code
            elsif game_type == 'code'
                @choice = @computer.guess
                puts "Computer guesses #{@choice}"
            end
        end
        def check_status(@game_type)
            if self.feedback(@choice) == "222222"
                if @game_type = "guess"
                    @player_score += 1
                else
                    @computer_score += 1
                    puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
                end
                @guesses_left = 12
                self.new_game
                puts "Guesser wins! Starting new game"
            elsif self.feedback(@choice) != "222222"
                @guesses_left -= 1
                if @guesses_left < 0
                    if @game_type == "code"
                        @computer_score += 1
                    else
                        @player_score += 1
                        puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
                    end
                    @guesses_left = 12
                    self.new_game
                    puts "Coder loses! Starting new game"
                else
                    puts self.feedback(@choice)
                end
            end
        end
        def new_game
            puts "Enter guess to begin guessing role, code to create code for computer to guess."
            @game_type = gets.chomp
            unless game_type =~ /^guess$|^code$/
                puts "Enter a valid input"
                @game_type = gets.chomp
            if @game_type = "guess"
                @code = @computer.generate
            else
                puts "Enter your code!"
                @code = @player.enter_code
            end
        end

        def feedback(guess_code)
            feedback_code = "000000"
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
                            elsif
                                duplicates[num] += 1
                            end
                        end
                    end
                end
                (0..5).each do |i|
                    if guess_code[i] != @code[i]
                        duplicates.each do |x,y|
                            if guess_code[i].to_i == x && y > 0
                                duplicates[x] = y - 1
                                feedback_code[i] = "1"
                            end
                        end
                    end
                end
            end
            check_for_wrong_spot(guess_code, feedback_code)
            check_for_correct(guess_code, feedback_code)
            return feedback_code
        end
        def game_loop
            while true
                self.display_prompt
                self.check_status
            end
        end
    end
include Mastermind
game = Game.new
game.game_loop
