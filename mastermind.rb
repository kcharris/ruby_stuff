=begin 
Master mind is a game where 2 players take turns guessing a number of times an opponents code made with
a number of different pieces where the code maker gives feedback with two different types of pieces about 
which of the guessed code is correct. Those two feedback pieces represent: 1. that a guessed piece is in a
correct spot in the right color, 2. and the correct piece played in the wrong position. If there are more of
one type of guessed piece than there are of that type piece in the code then the extra pieces will not be
awarded feedback.
For example. Pieces 1..6 for a code 123154 and a guess of 443456 feedback could be 201010.

There is a computer, player, computer code, guessed code, feedback code, game as a whole, counter for guesses,
display, and prompt. As well as a way to reset and keep track of wins and losses.
=end
module Mastermind
    class Computer
        attr_reader :code
        def generate_code
            @code = ""
            6.times do
                @code += (1 + rand(6)).to_s
            end
            @code = "121134"
        end
        def feedback(player_code)
            feedback_code = "000000"
            def check_for_correct(player_code, feedback_code)
                (0..5).each do |x|
                    if player_code[x] == @code[x]
                        feedback_code[x] = "2"
                    end
                end
            end
            def check_for_wrong_spot(player_code, feedback_code)
                #checks duplicates in case there are more than in code
                duplicates = {}
                (1..6).each do |num|
                    (0..5).each do |index|
                        if num.to_s == @code[index] && player_code[index] != @code[index]
                            if duplicates[num] == nil
                                duplicates[num] = 1
                            elsif
                                duplicates[num] += 1
                            end
                        end
                    end
                end
                (0..5).each do |i|
                    if player_code[i] != @code[i]
                        duplicates.each do |x,y|
                            if player_code[i].to_i == x && y > 0
                                duplicates[x] = y - 1
                                feedback_code[i] = "1"
                            end
                        end
                    end
                end
            end
            check_for_wrong_spot(player_code, feedback_code)
            check_for_correct(player_code, feedback_code)
            return feedback_code
        end
    end
    class Player
        def enter_input
            guess = gets.chomp
            unless guess =~ /^[1-6]{6}$/
                puts "Enter a valid input"
                guess = gets.chomp
            end
            return guess
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
            @computer.generate_code
            puts "New game START"
        end
        def display_prompt
            puts "Score is Player: #{@player_score} vs Computer: #{@computer_score}"
            puts "Guesses left = #{@guesses_left}"
            puts "Enter a six digit code"
            puts "Feedback: 0 means no hit, 1 means right number wrong place, 2 means correct"
            @choice = @player.enter_input
        end
        def check_status
            if @computer.feedback(@choice) == "222222"
                @player_score += 1
                @guesses_left = 12
                @computer.generate_code
                puts "You win! Starting new game"
            elsif @computer.feedback(@choice) != "222222"
                @guesses_left -= 1
                if @guesses_left < 0
                    @computer_score +=1
                    @guesses_left = 12
                    @computer.generate_code
                    puts "You lose! Starting new game"
                else
                    puts @computer.feedback(@choice)
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
include Mastermind
game = Game.new
game.game_loop
