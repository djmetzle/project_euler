#!/usr/bin/ruby

require 'ostruct'

MAX=100

def digital_sum n
   return n.to_s.split('').map(&:to_i).reduce(:+)
end

def power_iter base, max_pow
   return Enumerator.new do |e|
      (2..max_pow).each { |p|
         value = OpenStruct.new
         value.base = base
         value.power = p
         value.n = base ** p
         e.yield value unless value.n < 10
      }
   end
end

def base_iter max_base
   return Enumerator.new do |e|
      (1..max_base).each { |base|
         p_iter = power_iter base, max_base
         p_iter.each { |power|
            power.sum_match = digital_sum(power.n) == power.base
            e.yield power
         }
      }
   end
end

e = base_iter MAX
n = 1
e.select {|power| power.sum_match }.map {|power| power.n}.sort.each { |power|  puts "#{n}:#{power}"; n+=1 }
