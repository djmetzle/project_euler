#!/usr/bin/ruby

MAX = 30

def power_sum? n
   is_power_sum = false
   digital_sum = n.to_s.split('').map(&:to_i).reduce(:+)
   return false if digital_sum == 1

   power = 1
   loop do
      test_exp = digital_sum**power
      if test_exp == n
         is_power_sum = true
      end
      if test_exp >= n
         break
      end
      power += 1
   end

   return is_power_sum
end

found = 0
test_n = 11

loop do
   if power_sum? test_n
      found += 1
      puts "#{found} : #{test_n}"
   end
   if found >= MAX
      break
   end
   test_n += 1
end
