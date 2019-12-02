#!/usr/bin/ruby
puts "Euler 131"

require 'prime'

#MAX=1e2
MAX=1e6

cubes = (1..MAX).map { |n| n**3 }

count = 0
(1...MAX).each { |i|
   d = cubes[i] - cubes[i-1]
   next unless d < MAX
   if Prime.prime? d
      puts "Found: #{d}"
      count += 1
   end
}

puts count
