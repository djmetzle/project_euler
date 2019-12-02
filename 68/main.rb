#!/usr/bin/ruby

# Euler 68

N=6
#N=10

values = (1..N)
p values

combos = values.to_a.combination(3).to_a
p combos
p combos.length

