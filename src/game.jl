# functions related to accessing/mutating the game state
export Game, run!

const NUM_SUITS = 5

# creates a new game and returns it
# N - number of players
function Game(players::Vector{Player})
  deck = Deck()
  N = length(players) # number of players
  assert(2<N<5)
  nhand = N==5 ? 4 : 5 # hand size
  [[push!(p.hand,deal!(deck)) for i=1:nhand] for p in players] # deal hands to each player
  # return the game with the deck, reduced deck, zeroed discard pile, 8 info chips, 3 fuse chips
  Game(players, deck, zeros(NUM_SUITS), zeros(NUM_SUITS*5), 8, 3, 1, N)
end

##########################
## PRIVATE GAME METHODS ##
##########################

#=
end conditions for the game:
- number 5 of any suit is discarded
- deck is empty and finalCountdown == 0
- fuse = 0
- players win
=#
function isgameover(g::Game)
  ans = false
  # discard pile contains a 5
  if any([g.discard[card2idx(Card(i,5))] for i=1:NUM_SUITS])
    print("5 discarded")
    ans = true
  end
  # deck is empty and everyone has gone 1 more time
  if (length(g.deck) == g.finalCountdown == 0)
    print("Deck Empty & Out of turns")
    ans = true
  end
  # ran out of fuses
  if (g.fuse==0)
    print("Fuse == 0")
    ans = true
  end
  # board is completed
  if all(g.board==5)
    print("Board Completed")
    ans = true
  end
  ans
end

# convert card to a linear index corresponding to that suit, pair
card2idx = c-> sub2ind([NUM_SUITS,5],c.suit,c.num)

######################
## GAME API METHODS ##
######################

# simulates hanabi and returns final game state
function run!(g::Game)
  while (!isgameover(g))
    on_turn!(g.players[g.currentPlayer], g)
    g.currentPlayer = mod(g.currentPlayer,length(g.players))+1 # increment player index
  end
  g
end

#######################
## BROADCAST METHODS ##
#######################

function broadcast_play!(c::Card, g::Game)
  [on_play!(p,g,c) for p in g.players]
end

function broadcast_info!(j::Integer, isSuit::Bool, v::Integer, index::Vector{Integer}, g::Game)
  [on_info!(p,j,isSuit,v,index,g) for p in g.players]
end

function broadcast_discard!(c::Card, g::Game)
  [on_discard!(p,c,g) for p in g.players]
end

########################
## PLAYER API METHODS ##
########################

function play!(c::Card, g::Game)
  if isvalidmove(c,g)
    g.board[c.suit]+=1
    if g.board[c.suit]==5 # if tower completed, we recover 1 info
      g.info+=1
    end
  else
    g.fuse-=1
  end
  broadcast_play!(c,g)
end

function giveinfo!(j::Integer, isSuit::Bool, v::Integer, index::Vector{Integer}, g::Game)
  g.info-=1
  broadcast_info!(j, isSuit, v, index, g)
end

# returns new card obtained from discard
function discard!(p::Player, c::Card, g::Game)
  g.discard[card2idx(c)] += 1
  push!(p.hand,deal!(g.deck))
  broadcast_discard!(c,g)
end
