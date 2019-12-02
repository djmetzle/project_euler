#!/usr/bin/ruby

require 'set'
require 'prime'

MAX=1000
MAX=4e6

def n_solutions n
   return 1 if n <= 2
   primes, powers = Prime.prime_division(n).transpose
   divisor_size = powers.map { |p| p + 1 }.reduce(:*)
   return (divisor_size - 1) / 2 + 1
end


$prod = 1
Prime.each do |p|
   $prod *= p
   n = n_solutions($prod*$prod)
   puts "#{$prod}: #{n}"
   if n > MAX
      $upper = p
      break
   end
end

puts "Found upper bound #{$upper}..."

$base_primes = []

Prime.each($upper) { |p| $base_primes.push p }

$powers = []

$base_primes.each_with_index { |p, i|
   $powers[i] = []
   power = 0
   while true do
      $powers[i].push [p, power]
      power += 1
      break if p ** power > 100
   end
}

p $powers

   sols = $powers.pop.product(*$powers).map { |p_set| 
      p_set.reduce(1) {
         |memo, power| memo * power[0] ** power[1]
      }
   }.sort.map { |power|
      [ power, n_solutions(power**2) ]
   }.select { |power| power[1] > MAX }.first

pp sols.sort { |a,b| a[1] <=> b[1] }
