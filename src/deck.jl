
function Deck()
  deck=Card[]
  for s=1:NUM_SUITS
    [push!(deck,Card(s,1)) for i=1:3]
    [[push!(deck,Card(s,n)) for i=1:2] for n=2:4]
    push!(deck,Card(s,5))
  end
  shuffle!(deck)
end

# takes card from deck and inserts it into front of player's hand
function deal!(d::Deck)
  shift!(d)
end

export deal!, Deck
