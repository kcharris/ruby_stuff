# ruby_stuff
Master mind is a game where 2 players take turns guessing a number of times an opponents code made with
a number of different pieces where the code maker gives feedback with two different types of pieces about 
which of the guessed code is correct. Those two feedback pieces represent: 1. that a guessed piece is in a
correct spot in the right color, 2. and the correct piece played in the wrong position. If there are more of
one type of guessed piece than there are of that type piece in the code then the extra pieces will not be
awarded feedback.

For example. Pieces 1..6 for a code 123154 and a guess of 443456 feedback could be 201010.

add functionallity to allow player to choose whether he guesses or creates the code. game display prompt or player input prevents this from happenning. player needs ability to choose a code, this can be taken care of by player input.

Computer generate code needs return replaced