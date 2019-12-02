#!/usr/bin/ruby

require 'set'

puts 'Euler #171'
puts

def f n
   return n.to_s.split('').map(&:to_i).map{|x| x*x}.reduce(:+)
end

def fac n
   return n.downto(1).inject(:+)
end

$squares = [1]
$last_square = 1
def square? n
   while $last_square**2 <= n do
      $squares.push($last_square**2)
      $last_square += 1
   end
   return $squares.include?(n)
end

puts "Tests:"
TESTS=[3, 25, 442]
TESTS.each { |val| puts "f(#{val}) = #{f val }" }
puts 

BASE_DIGITS=(1..9).to_a

MAX_EXP=20
$sum = 0
$values = Set.new  
(1..MAX_EXP).each do |l|
   puts l
   BASE_DIGITS.repeated_combination(l).lazy.select { |c|
      square?(c.map {|i| i**2}.inject(:+))
   }.each { |x|
      x.permutation(l).each { |p|
         val = p.join('').to_i
         $values.add(val)
      }
   }
end

p $values.inject(:+)
