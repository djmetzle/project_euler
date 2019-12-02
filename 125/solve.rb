#!/usr/bin/ruby

require 'set'

MAX = 1e8

sums = Set.new

for base in (1..MAX)
   sum = base ** 2
   break if sum >= MAX
   for iter in ((base+1)..MAX)
      sum += iter ** 2
      break if sum >= MAX
      sums.add sum
   end
end

palindrome = lambda do |n|
   reverse = n.to_s.reverse.to_i
   return reverse == n
end

sums.keep_if &palindrome

p sums.to_a.reduce(:+)
