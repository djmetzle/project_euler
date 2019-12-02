#!/usr/bin/ruby

# Euler 108

require 'prime'
require 'set'

#N = 3
N = 1000

def sol_count(n)
	#puts "Sol Count #{n} #{n*n}"
	solutions = Set.new
	divisors = Prime.prime_division(n*n)
	#p divisors
	divisors.each { |d|
		base, pow = d
		(1..pow).each { |p|
			s = base ** p
			r = n*n / s
			#puts "= #{s} #{r}"
			x = Rational(1, n+s)
			y = Rational(1, n+r)
			sol = Set[x,y]
			solutions.add(sol)
		}
	}
	return solutions.count
end

n = 1
while n
	n += 1
	if sol_count(n) >= N
		break
	end
	if n % 1000 == 0
		puts n
	end
end

puts "ANS: #{n}"
