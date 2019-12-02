#!/usr/bin/ruby
puts "Problem 121"

N = 15

$outcomes = [1]

def iterate outcomes, n
   new_outcomes = Array.new(n+1,0)
   (0...n).each { |i|
      new_outcomes[i] += outcomes[i]
   }
   (1..n).each { |i|
         new_outcomes[i] += outcomes[i-1] * n
   }
   return new_outcomes
end

(1..N).each { |n|
   $outcomes = iterate $outcomes, n
}

p $outcomes

num = (0..N).select { |i| i < N - i }.map {|i| $outcomes[i] }.reduce(:+)
den = (0..N).map {|i| $outcomes[i] }.reduce(:+)

puts "#{num}/#{den}"
p (den)/num

