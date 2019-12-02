#!/usr/bin/ruby

# Euler 121

N = 4

prob_blue = {}
prob_red = {}

(1..N).each { |n|
	prob_blue[n] = Rational(1,n+1)
	prob_red[n] = Rational(n,n+1)
}

p prob_blue
p prob_red

prob_sums = {}

(1..N).each { |n|
	
}



