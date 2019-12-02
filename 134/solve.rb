#!/usr/bin/ruby
puts "Problem #134"

require 'prime'

#MAX=20
MAX=1e6

$prime_pairs = []

def find_pairs
   last_p = 5
   Prime.each { |p|
      next if p <= 5
      $prime_pairs.push([last_p, p])
      last_p = p
      return if p > MAX
   }
end

def find_s pair
   p1 = pair.first
   p2 = pair.last
   n = 1
   while ((n.to_s + p1.to_s).to_i) % p2 != 0 do
      n += 1
   end
   return (n.to_s + p1.to_s).to_i
end

find_pairs

p $prime_pairs.map { |pair| find_s pair }.reduce(:+)
