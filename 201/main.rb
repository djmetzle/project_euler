#!/usr/bin/ruby

# Euler 201

def u(set, n)
	reduced = []
	sums = set.combination(n).each { |c|
		s = c.reduce(:+)
		reduced[s] ||= 0
		reduced[s] += 1
	}
	return reduced
end

S = (1..100).to_a.map { |i| i * i }

B = [1,3,6,8,10,11]

puts u(S,50).reduce(:+)
