# Hanabi

[![Build Status](https://travis-ci.org/ericjang/Hanabi.jl.svg?branch=master)](https://travis-ci.org/ericjang/Hanabi.jl)

A simple game engine for [Hanabi](https://en.wikipedia.org/wiki/Hanabi_%28card_game%29) written in Julia.

This module is designed to be simple enough for beginners to understand, while conforming to style guide and best practices common in larger Julia projects (i.e multiple dispatch, module organization, test coverage).

## Rules

The game engine conforms to the rules in the [Wikipedia article](https://en.wikipedia.org/wiki/Hanabi_%28card_game%29).

## Installation

Launch a julia REPL and run the following command:

```julia
julia> Pkg.add("Hanabi.jl")
```
## Simple Example

Here is an out-of-the-box example of simulating a game of Hanabi:
```julia
using Hanabi

g = Game([SimplePlayer() for i=1:4]) # create a new game with 4 players
g = run!(g) # simulate the game
print(getScore(g))
```

## Custom Strategies

You can implement per-player custom strategies. See the ```SimplePlayer``` composite type for an example.

```

```



TODO - implement https://en.wikipedia.org/wiki/AIXI
