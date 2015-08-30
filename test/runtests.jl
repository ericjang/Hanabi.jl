using Hanabi
using Base.Test

## DATA TYPES ##

# card
c= Card(1,2)
@test c.suit == 1
@test c.num == 2

# deck
deck = Deck()

n = length(deck)
tmp = [deal!(deck) for i=1:n]
@test length(tmp)==50

# player/simpleplayer
deck = Deck()
p = SimplePlayer()
[push!(p.hand,deal!(deck)) for i=1:5]
[println(c) for c in p.hand]

# game
g = Game([SimplePlayer() for i=1:4])
