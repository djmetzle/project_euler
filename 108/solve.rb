#!/usr/bin/ruby

require 'set'
require 'prime'

#N = 1000
N=4e6

def n_solutions n
   primes, powers = Prime.prime_division(n).transpose
   divisor_size = powers.map { |p| p + 1 }.reduce(:*)
   return (divisor_size - 1) / 2 + 1
end


p n_solutions(180180*180180)

product = 1
Prime.each(50) do |p|
   product *= p
   p p, n_solutions(product**2)
end

n = 
loop do
   n += 1
   if n % 1000 == 0
      p "#{n}..."
   end
   if n_solutions(n*n) > N
      puts "Max: #{n}"
      exit 0
   end
end

