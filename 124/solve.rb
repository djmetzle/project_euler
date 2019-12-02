#!/usr/bin/ruby
require 'prime'

N = 100000

RadPair = Struct.new(:n, :rad)

def rad n
   return RadPair.new(1, 1) if n == 1
   divisors = Prime.prime_division(n).map { |p| p[0] }
   return RadPair.new n, divisors.reduce(:*)
end

sorted = (1..N).map {
      |n| rad n
   }.sort { |a, b|
      a.rad == b.rad ? a.n <=> b.n : a.rad <=> b.rad
   }

#puts sorted[4-1].n
#puts sorted[6-1].n
puts sorted[10000-1].n
