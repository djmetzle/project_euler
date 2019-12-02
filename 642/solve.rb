#!/usr/bin/ruby
puts "Problem #642"

require 'prime'

def f n
   return n.prime_division.last.first
end

def F n
   return (2..n).lazy.inject { |sum, i| sum + f(i) }
end

puts F(10)
puts F(100)
puts F(1e4)

sol =  F(201820182018)
puts sol
puts sol % 1e9

