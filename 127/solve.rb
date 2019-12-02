#!/usr/bin/ruby

#:MAX = 120000
MAX = 1000

require 'prime'
require 'ostruct'

def rad n
   factors = Prime.prime_division(n)
   return factors.map {|f| f[0]}.reduce(:*)
end


$first_rule = lambda { |tuple|
   return false unless tuple.a.gcd(tuple.b) == 1
   return false unless tuple.a.gcd(tuple.c) == 1
   return false unless tuple.b.gcd(tuple.c) == 1
   return true
}

$second_rule = lambda { |tuple|
   return tuple.a < tuple.b
}

$third_rule = lambda { |tuple|
   return tuple.a + tuple.b == tuple.c
}

$fourth_rule = lambda { |tuple| 
   prod = tuple.a * tuple.b * tuple.c
   return rad(prod) < tuple.c
}

def tuples c
   return Enumerator.new do |e|
      (1..(c/2)).lazy.each { |a|
         b = c - a
         tuple = OpenStruct.new(:a => a, :b => b, :c => c)
         e.yield tuple if $third_rule.call(tuple)
      }
   end
end

def all_enum
   return Enumerator.new do |e|
      (3..MAX).lazy.each { |c|
         tuples(c).lazy.select { |tuple|
            $fourth_rule.call(tuple)
         }.select { |tuple|
            $first_rule.call(tuple)
         }.each { |tuple| e.yield tuple }
      }

   end
end

#tuple = OpenStruct.new(:a => , :b =>, :c => )
tuple = OpenStruct.new(:a => 5 , :b => 27, :c => 32)

p all_enum().lazy.map { |tuple| tuple.c }.reduce(:+)
