#!/usr/bin/ruby

require 'prime'

# Euler 77

N=10

$ways = [0,0,1,1,1,2,2,3,3,4]

def find_ways(n)
	if $ways[n]
		return $ways[n]
	end
	n_ways = 0
	Prime.each n do |prime|
		if Prime.prime?(n)
			n_ways += 1
		end
		n_ways += find_ways(n-prime)
		puts "#{n} : #{n_ways}"
	end
	$ways[n] = n_ways
	return n_ways
end

p $ways

p find_ways(10)
