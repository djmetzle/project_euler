#!/usr/bin/ruby
# Problem 123

MAX = 1e10

require 'prime'

def calc_r p, n
   return ((p-1)**n + (p+1)**n) % (p**2) 
end

nth = 0

Prime.each { |p|
   nth += 1
   next if nth % 2 == 0
   r_value = calc_r p, nth
   if r_value > MAX
      puts "#{nth}: #{p} - #{calc_r p, nth}"
      exit
   end
}

