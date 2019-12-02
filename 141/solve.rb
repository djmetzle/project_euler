#!/usr/bin/ruby

require 'prime'

MAX=1e5

def factors_of(number)
  primes, powers = number.prime_division.transpose
  exponents = powers.map{|i| (0..i).to_a}
  divisors = exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map{|prime, power| prime ** power}.inject(:*)
  end
  return divisors.sort.map{|div| [div, number / div]}
end

def progressive? n
	p n.prime_division
end

progressive? 58
