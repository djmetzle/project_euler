#!/usr/bin/ruby

require 'set'

MAX = 1e3

def r a, n
   return ((a-1)**n + (a+1)**n) % (a**2)
end

def r_vals a
   n = 1
   cycle_length = 1
   r_list = []
   loop do
      current_r =  r a, n
      r_list[n] = current_r
      if r_list[n - cycle_length] == r_list[n]
         break;
      else
         cycle_length += 1
      end
      n += 2
   end
   return r_list
end

p (3..MAX).map { |a|
   (r_vals a).reject(&:nil?).max
}.reduce(:+)
