#=
Implementation of an AbstractPlayer.

Strategy:
- Each SimplePlayer assumes the other players are SimplePlayers
- Each SimplePlayer is a perfect card-counter
- Each SimplePlayer add

=#

export SimplePlayer

type SimplePlayer
  hand::Vector{Card}
  SimplePlayer() = new([])
end


function onTurn!(p::SimplePlayer, g::Game)
  # play top card
end

function on_play!(p::SimplePlayer,c::Card,g::Game)
  # do nothing
end

function on_info!(p::SimplePlayer,j::Integer,isSuit::Bool, v::Integer, index::Vector{Integer})
  # update probability distribution
end

function on_discard!(p::SimplePlayer, c::Card, g::Game)
  # update probability distribution
end
