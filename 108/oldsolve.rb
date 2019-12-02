#!/usr/bin/ruby

puts "Euler 108"
require 'prime'

def prime_composites_enum
   return Enumerator.new do |penum|
      n = 0
      loop do 
         n += 1
         prime_composites = []
         puts "searching #{n} primes..."
         primes = Prime.first(n)
         max_power = 0
         loop do
            max_power += 1
            break if 2**max_power > primes.last
         end
         puts "searching to max power #{max_power}.."
         lazy_pows = (1..max_power).to_a.repeated_permutation(n).lazy
         lazy_pows.map { |pow_set|
            [primes, pow_set].transpose.map { |x| x.reduce(:**) }.reduce(:*)
         }.select { |r| r < primes.last }.sort.each { |n|
            penum.yield n
         }
      end
   end
end

prime_composites_enum.lazy.take(150).lazy.each { |x| p x}
exit 0

def n_solutions n
   solutions = 0
   (1..n).each { |r|
      if n*n % r == 0
         solutions += 1
      end
   }
   return solutions
end

best = 0
n=4
while true do
   n+=1
   next if Prime.prime? n
   if n % 1000 == 0
      puts n
   end
   n_sols = n_solutions n
   if n_sols > best
      best = n_sols
      puts "New best: #{n} #{n_sols}"
   end
   if n_sols > 1000
      puts "SOLUTION: #{n}: #{n_sols}"
      exit 0
   end
end
