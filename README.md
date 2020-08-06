# Test Job: Create a card game API

Create a Card Game library of classes which could be used to create any number of basic card
games. You'll need at least a Deck class and a Card class.

## Create an JSON API in Ruby on Rails that provides endpoints to do the following:

1. Instantiate a game, which instantiates a new deck of cards and shuffles it; requires names of
two players and returns game representation in JSON - id and the names of the players.

2. Draw a card from the game deck: requires game id and returns either a card representation in
JSON or returns an appropriate error code that the deck is empty.

3. Compare two cards by providing their human readable name (e.g. "Ace of Spades", "10 of
Clubs", "Queen of Hearts”).

* Upon initialization, a deck is filled with 52 cards (13 from each of 4 suits)

* Comparing is based on rank 1 to 13 ("ace" is 1, "king" is 13) and suit (“spades" < “diamonds” <
“hearts" < “clubs”)

* Bonus points for automated tests!
