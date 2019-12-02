#!/usr/bin/ruby

# Euler 108

require 'prime'
require 'set'

#N = 3
N = 1000

def sol_count(n)
#	puts "Sol Count #{n}"
	solutions = Set.new
	divisors = Prime.prime_division(n)
	divisors.unshift([1,1])
	divisors.each { |d|
		base, pow = d
		(1..pow).each { |p|
			k = base ** p
			mn = n / k
			subdivisors = Prime.prime_division(mn)
			subdivisors.unshift([1,1])
			subdivisors.each { |subd|
				subbase, subpow = subd
				(1..subpow).each { |subp|
					subm = subbase ** subpow
					subn = mn / subm
					x = Rational(1, k*subm*(subm+subn))
					y = Rational(1, k*subn*(subm+subn))
					sol = Set[x,y]
					solutions.add(sol)
				}
			}
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
