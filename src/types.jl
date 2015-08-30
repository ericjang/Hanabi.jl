export Card, Deck, Hand, Player, Game

type Card
  suit::Integer # 1,2,3,4,5 (i.e. fireworks color in the tile game)
  num::Integer # 1,2,3,4,5 # 3 1s, 2 2s, 3s, 4s, 1 5
end

typealias Deck Vector{Card}
typealias Hand Vector{Card}

abstract Player

# struct containing game state
type Game
  players::Vector{Player} # list of players
  deck::Vector{Card} # queue of cards
  board::Vector{Integer} # NUM_SUITS
  discard::Vector{Integer} # NUM_SUITS*5 array of counts of items discarded
  info::Integer # how many info tokens remaining
  fuse::Integer # how many fuse tokens remaining
  currentPlayer::Integer # index of current player
  finalCountdown::Integer # counter for last move when deck runs out
end
